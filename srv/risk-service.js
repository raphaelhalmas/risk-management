const cds = require('@sap/cds')

/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
module.exports = cds.service.impl(async function () {
    const businessPartnerAPI = await cds.connect.to("API_BUSINESS_PARTNER");
    const { BusinessPartner } = this.entities;

    this.after('READ', 'Risk', risksData => {
        const risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(risk => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            }
            else {
                risk.criticality = 2;
            }
        });
    });

    /**
     * Event-handler for read-events on the BusinessPartners entity.
     * Each request to the API Business Hub requires the apikey in the header.
     */
    this.on("READ", BusinessPartner, async (req) => {
        req.query.where("LastName <> '' and FirstName <> ''");

        return await businessPartnerAPI.transaction(req).send({
            query: req.query,
            headers: {
                apikey: process.env.apikey,
            }
        });
    });

    /**
     * Event-handler on risks.
     * Retrieve BusinessPartner data from the external API
     */
    this.on("READ", 'Risk', async (req, next) => {
        if (!req.query.SELECT.columns) return next();

        const expandIndex = req.query.SELECT.columns.findIndex(
            ({ expand, ref }) => expand && ref[0] === "bp"
        );

        if (expandIndex < 0) return next();

        req.query.SELECT.columns.splice(expandIndex, 1);

        if (!req.query.SELECT.columns.find((column) => column.ref.find((ref) => ref == "bp_ID"))) {
            req.query.SELECT.columns.push({ ref: ["bp_ID"] });
        }

        try {
            res = await next();
            res = Array.isArray(res) ? res : [res];

            await Promise.all(
                res.map(async (risk) => {
                    const bp = await businessPartnerAPI.transaction(req).send({
                        query: SELECT.one(this.entities.BusinessPartner)
                            .where({ ID: risk.bp_ID })
                            .columns(["ID", "LastName", "FirstName"]),
                        headers: {
                            apikey: process.env.apikey,
                        },
                    });
                    risk.bp = bp;
                })
            );
        }
        catch (error) {
        }
    });
});
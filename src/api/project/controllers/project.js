"use strict";

/**
 * project controller
 */

const { createCoreController } = require("@strapi/strapi").factories;

module.exports = createCoreController("api::project.project", ({ strapi }) => ({
  async find(ctx) {
    const { query } = ctx;

    const entity = await strapi.entityService.findMany("api::project.project", {
      ...query,
      populate: ["thumbnail", "galery"],
    });

    const sanitizedEntity = await this.sanitizeOutput(entity, ctx);

    return this.transformResponse(sanitizedEntity);
  },

  async findOne(ctx) {
    const { id: slug } = ctx.params;
    const { query } = ctx;

    if (!query.filters) query.filters = {};
    query.filters.slug = { $eq: slug };

    const entity = await strapi.service("api::project.project").find({
      ...query,
      populate: {
        thumbnail: true,
      },
      withRelated: {
        images: (qb) => {
          qb.columns("data");
        },
      },
    });

    const { results } = await this.sanitizeOutput(entity, ctx);

    return this.transformResponse(results[0]);
  },
}));

'use strict'

/**
 * technology controller
 */

const { createCoreController } = require('@strapi/strapi').factories

module.exports = createCoreController(
  'api::technology.technology',
  ({ strapi }) => ({
    async find(ctx) {
      const { query } = ctx

      const entity = await strapi.entityService.findMany('api::technology.technology', {
        ...query,
        populate: 'logo',
      })

      const sanitizedEntity = await this.sanitizeOutput(entity, ctx)

      return { data: sanitizedEntity }
    },
  }),
)

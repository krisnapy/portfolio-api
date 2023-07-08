'use strict'

/**
 * home controller
 */

const { createCoreController } = require('@strapi/strapi').factories

module.exports = createCoreController('api::home.home', ({ strapi }) => ({
  async find(ctx) {
    const { query } = ctx

    const entity = await strapi.entityService.findMany('api::home.home', {
      ...query,
      populate: {
        skills: {
          populate: {
            technologies: {
              populate: 'logo',
            },
          },
        },
        banner: {
          populate: ['bannerTitles', 'image'],
        },
        projects: {
          populate: {
            projects: {
              populate: ['thumbnail', 'gallery'],
            },
          },
        },
      },
    })

    const sanitizedEntity = await this.sanitizeOutput(entity, ctx)

    return { data: sanitizedEntity }
  },
}))

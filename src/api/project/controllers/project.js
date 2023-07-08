'use strict'

/**
 * project controller
 */

const { createCoreController } = require('@strapi/strapi').factories

module.exports = createCoreController('api::project.project', ({ strapi }) => ({
  async find(ctx) {
    const { query } = ctx

    const entity = await strapi.entityService.findMany('api::project.project', {
      ...query,
      populate: ['thumbnail', 'gallery'],
    })

    const sanitizedEntity = await this.sanitizeOutput(entity, ctx)

    const cleanThumbnail = (thumbnail) => {
      const { name, url, formats } = thumbnail

      const cleanedThumbnail = {
        name: name,
        url: url,
        lowRes: formats?.small?.url,
      }

      return cleanedThumbnail
    }

    const cleanGallery = (gallery) => {
      const { name, url, formats } = gallery

      const cleanedGallery = {
        name,
        url,
        lowRes: formats?.small?.url,
      }

      return cleanedGallery
    }

    sanitizedEntity.forEach((obj) => {
      obj.thumbnail = cleanThumbnail(obj.thumbnail)
      obj.gallery = obj.gallery.map(cleanGallery)
    })

    return { data: sanitizedEntity }
  },

  async findOne(ctx) {
    const { id: slug } = ctx.params
    const { query } = ctx

    if (!query.filters) query.filters = {}
    query.filters.slug = { $eq: slug }

    const entity = await strapi.service('api::project.project').find({
      ...query,
      populate: {
        thumbnail: true,
      },
      withRelated: {
        images: (qb) => {
          qb.columns('data')
        },
      },
    })

    const response = await this.sanitizeOutput(entity, ctx)

    const results = response.results[0]

    const data = {
      ...results,
      thumbnail: {
        highRes: results.thumbnail.url,
        lowRes: results.thumbnail.formats.small.url,
      },

      gallery: {
        highRes: results.gallery.url,
        lowRes: results.gallery.formats.small.url,
      },
    }

    return this.transformResponse(data)
  },
}))

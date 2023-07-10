module.exports = ({ env }) => ({
  upload: {
    config: {
      provider: 'cloudinary',
      providerOptions: {
        cloud_name: env('CLOUDINARY_NAME'),
        api_key: env('CLOUDINARY_KEY'),
        api_secret: env('CLOUDINARY_SECRET')
      },
      actionOptions: {
        upload: {},
        delete: {}
      }
    }
  },
  'strapi-neon-tech-db-branches': {
    enabled: env.bool('NEON_ENABLED', true),
    config: {
      neonApiKey: env('NEON_API_KEY'),
      neonProjectName: env('NEON_PROJECT_NAME'),
      neonRole: env('NEON_ROLE'),
      gitBranch: 'main'
    }
  }
})

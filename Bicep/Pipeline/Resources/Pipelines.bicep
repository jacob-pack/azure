resource symbolicname 'Microsoft.DevOps/pipelines@2020-07-13-preview' = {
  location: 'string'
  name: 'string'
  properties: {
    bootstrapConfiguration: {
      sourceRepository: {
        authorization: {
          authorizationType: 'string'
          parameters: {
            {customized property}: 'string'
          }
        }
        defaultBranch: 'string'
        id: 'string'
        properties: {
          {customized property}: 'string'
        }
        repositoryType: 'string'
      }
      template: {
        id: 'string'
        parameters: {
          {customized property}: 'string'
        }
      }
    }
    pipelineType: 'string'
    // For remaining properties, see PipelineProperties objects
  }
  tags: {
    {customized property}: 'string'
  }
}

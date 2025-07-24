//while i do plan on breaking these up into their respective modules
//for the sake of ease and clarity of flow I am keeping MG related resource definitions here

//Additionally, while i would normally modularize the invocation of the managementGroup module
//I believe there is benefit in the clarity of inline instantiation for these resources


targetScope = 'tenant'

param topLevelManagementGroupPrefix string = 'alz'
param topLevelManagementGroupSuffix string = ''
param topLevelManagementGroupDisplayName string = 'Azure Landing Zones'
param topLevelManagementGroupParentId string = ''
param landingZoneMgAlzDefaultsEnable bool = true
param platofrmMgAlzDefaultsEnable bool = true
param landingZoneMgConfidentialEnable bool = false
param landingZoneMgChildren object = {}
param platofrmMgChildren object = {}

// Platform and Child Management Groups
var varPlatformMg = {
  name: '${topLevelManagementGroupPrefix}-platform-${topLevelManagementGroupSuffix}'
  displayName: 'Platform'
}

// Used if platofrmMgAlzDefaultsEnable == true
var varPlatformMgChildrenAlzDefault = {
  connectivity: {
    displayName: 'Connectivity'
  }
  identity: {
    displayName: 'Identity'
  }
  management: {
    displayName: 'Management'
  }
}

// Landing Zones & Child Management Groups
var varLandingZoneMg = {
  name: '${topLevelManagementGroupPrefix}-landingzones-${topLevelManagementGroupSuffix}'
  displayName: 'Landing Zones'
}

// Used if landingZoneMgAlzDefaultsEnable == true
var varLandingZoneMgChildrenAlzDefault = {
  corp: {
    displayName: 'Corp'
  }
  online: {
    displayName: 'Online'
  }
}

// Used if landingZoneMgConfidentialEnable == true
var varLandingZoneMgChildrenConfidential = {
  'confidential-corp': {
    displayName: 'Confidential Corp'
  }
  'confidential-online': {
    displayName: 'Confidential Online'
  }
}

// Build final object based on input parameters for child MGs of LZs
var varLandingZoneMgChildrenUnioned = (landingZoneMgAlzDefaultsEnable && landingZoneMgConfidentialEnable && (!empty(landingZoneMgChildren))) ? union(varLandingZoneMgChildrenAlzDefault, varLandingZoneMgChildrenConfidential, landingZoneMgChildren) : (landingZoneMgAlzDefaultsEnable && landingZoneMgConfidentialEnable && (empty(landingZoneMgChildren))) ? union(varLandingZoneMgChildrenAlzDefault, varLandingZoneMgChildrenConfidential) : (landingZoneMgAlzDefaultsEnable && !landingZoneMgConfidentialEnable && (!empty(landingZoneMgChildren))) ? union(varLandingZoneMgChildrenAlzDefault, landingZoneMgChildren) : (landingZoneMgAlzDefaultsEnable && !landingZoneMgConfidentialEnable && (empty(landingZoneMgChildren))) ? varLandingZoneMgChildrenAlzDefault : (!landingZoneMgAlzDefaultsEnable && landingZoneMgConfidentialEnable && (!empty(landingZoneMgChildren))) ? union(varLandingZoneMgChildrenConfidential, landingZoneMgChildren) : (!landingZoneMgAlzDefaultsEnable && landingZoneMgConfidentialEnable && (empty(landingZoneMgChildren))) ? varLandingZoneMgChildrenConfidential : (!landingZoneMgAlzDefaultsEnable && !landingZoneMgConfidentialEnable && (!empty(landingZoneMgChildren))) ? landingZoneMgChildren : (!landingZoneMgAlzDefaultsEnable && !landingZoneMgConfidentialEnable && (empty(landingZoneMgChildren))) ? {} : {}
var varPlatformMgChildrenUnioned = (platofrmMgAlzDefaultsEnable && (!empty(platofrmMgChildren))) ? union(varPlatformMgChildrenAlzDefault, platofrmMgChildren) : (platofrmMgAlzDefaultsEnable && (empty(platofrmMgChildren))) ? varPlatformMgChildrenAlzDefault : (!platofrmMgAlzDefaultsEnable && (!empty(platofrmMgChildren))) ? platofrmMgChildren : (!platofrmMgAlzDefaultsEnable && (empty(platofrmMgChildren))) ? {} : {}

// Sandbox Management Group
var varSandboxMg = {
  name: '${topLevelManagementGroupPrefix}-sandbox-${topLevelManagementGroupSuffix}'
  displayName: 'Sandbox'
}

// Decomissioned Management Group
var varDecommissionedMg = {
  name: '${topLevelManagementGroupPrefix}-decommissioned-${topLevelManagementGroupSuffix}'
  displayName: 'Decommissioned'
}


// Level 1
resource resTopLevelMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: '${topLevelManagementGroupPrefix}${topLevelManagementGroupSuffix}'
  properties: {
    displayName: topLevelManagementGroupDisplayName
    details: {
      parent: {
        id: empty(topLevelManagementGroupParentId) ? '/providers/Microsoft.Management/managementGroups/${tenant().tenantId}' : contains(toLower(topLevelManagementGroupParentId), toLower('/providers/Microsoft.Management/managementGroups/')) ? topLevelManagementGroupParentId : '/providers/Microsoft.Management/managementGroups/${topLevelManagementGroupParentId}'
      }
    }
  }
}

// Level 2
resource resPlatformMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varPlatformMg.name
  properties: {
    displayName: varPlatformMg.displayName
    details: {
      parent: {
        id: resTopLevelMg.id
      }
    }
  }
}

resource resLandingZonesMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varLandingZoneMg.name
  properties: {
    displayName: varLandingZoneMg.displayName
    details: {
      parent: {
        id: resTopLevelMg.id
      }
    }
  }
}

resource resSandboxMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varSandboxMg.name
  properties: {
    displayName: varSandboxMg.displayName
    details: {
      parent: {
        id: resTopLevelMg.id
      }
    }
  }
}

resource resDecommissionedMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varDecommissionedMg.name
  properties: {
    displayName: varDecommissionedMg.displayName
    details: {
      parent: {
        id: resTopLevelMg.id
      }
    }
  }
}

// Level 3 - Child Management Groups under Landing Zones MG
resource resLandingZonesChildMgs 'Microsoft.Management/managementGroups@2023-04-01' = [
  for mg in items(varLandingZoneMgChildrenUnioned): if (!empty(varLandingZoneMgChildrenUnioned)) {
    name: '${topLevelManagementGroupPrefix}-landingzones-${mg.key}${topLevelManagementGroupSuffix}'
    properties: {
      displayName: mg.value.displayName
      details: {
        parent: {
          id: resLandingZonesMg.id
        }
      }
    }
  }
]

//Level 3 - Child Management Groups under Platform MG
resource resPlatformChildMgs 'Microsoft.Management/managementGroups@2023-04-01' = [
  for mg in items(varPlatformMgChildrenUnioned): if (!empty(varPlatformMgChildrenUnioned)) {
    name: '${topLevelManagementGroupPrefix}-platform-${mg.key}${topLevelManagementGroupSuffix}'
    properties: {
      displayName: mg.value.displayName
      details: {
        parent: {
          id: resPlatformMg.id
        }
      }
    }
  }
]


// Output Management Group IDs
output outTopLevelManagementGroupId string = resTopLevelMg.id
output outPlatformManagementGroupId string = resPlatformMg.id
output outPlatformChildrenManagementGroupIds array = [for mg in items(varPlatformMgChildrenUnioned): '/providers/Microsoft.Management/managementGroups/${topLevelManagementGroupPrefix}-platform-${mg.key}${topLevelManagementGroupSuffix}']

output outLandingZonesManagementGroupId string = resLandingZonesMg.id
output outLandingZoneChildrenManagementGroupIds array = [for mg in items(varLandingZoneMgChildrenUnioned): '/providers/Microsoft.Management/managementGroups/${topLevelManagementGroupPrefix}-landingzones-${mg.key}${topLevelManagementGroupSuffix}']

output outSandboxManagementGroupId string = resSandboxMg.id

output outDecommissionedManagementGroupId string = resDecommissionedMg.id

// Output Management Group Names
output outTopLevelManagementGroupName string = resTopLevelMg.name

output outPlatformManagementGroupName string = resPlatformMg.name
output outPlatformChildrenManagementGroupNames array = [for mg in items(varPlatformMgChildrenUnioned): mg.value.displayName]

output outLandingZonesManagementGroupName string = resLandingZonesMg.name
output outLandingZoneChildrenManagementGroupNames array = [for mg in items(varLandingZoneMgChildrenUnioned): mg.value.displayName]

output outSandboxManagementGroupName string = resSandboxMg.name

output outDecommissionedManagementGroupName string = resDecommissionedMg.name

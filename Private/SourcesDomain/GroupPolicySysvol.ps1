﻿$GroupPolicySysvol = @{
    Enable = $true
    Source = @{
        Name           = "GPO: Sysvol folder existance"
        Data           = {
            Get-GPOZaurrSysvol -IncludeDomains $Domain
        }
        Details        = [ordered] @{
            Area        = 'Security'
            Category    = ''
            Severity    = ''
            RiskLevel   = 0
            Description = "GPO Permissions are stored in Active Directory and SYSVOL at the same time. Sometimes when deleting GPO or due to replication issues GPO becomes orphaned (no SYSVOL files) or SYSVOL files exists but no GPO."
            Resolution  = ''
            Resources   = @(

            )
        }
        ExpectedOutput = $true
    }
    Tests  = [ordered] @{
        SysvolExists     = @{
            Enable     = $true
            Name       = 'GPO: Files on SYSVOL are not Orphaned'
            Parameters = @{
                WhereObject    = { $_.SysvolStatus -ne 'Exists' -or $_.Status -ne 'Exists' }
                ExpectedResult = $false # this tests things in bundle rather then per object of array
            }

        }
    }
}
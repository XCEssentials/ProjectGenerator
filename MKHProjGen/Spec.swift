//
//  Spec.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/15/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

//===

let My =
(
    repoName: "MyAwesomeFramework",
    deploymentTarget: "8.0",
    companyIdentifier: "khatskevich.maxim",
    developmentTeamId: "UJA88X59XP" // 'Maxim Khatskevich'
)

//===

let projects = [

    Project("Main") { p in
        
        p.configurations.all.override(
            
            "DEVELOPMENT_TEAM" << My.developmentTeamId,
            
            "SWIFT_VERSION" << "3.0",
            "VERSIONING_SYSTEM" << "apple-generic"
        )
        
        p.configurations.debug.override(
            
            "SWIFT_OPTIMIZATION_LEVEL" << "-Onone"
        )
        
        //---
        
        p.target(My.repoName, .iOS, .framework) { t in
            
            t.include("Src")
            
            //---
            
            t.configurations.all.override(
                
                "IPHONEOS_DEPLOYMENT_TARGET" << My.deploymentTarget,
                "PRODUCT_BUNDLE_IDENTIFIER" << "\(My.companyIdentifier).\(My.repoName)",
                "INFOPLIST_FILE" << "Info/Fwk.plist",
                
                //--- iOS related:
                
                "SDKROOT" << "iphoneos",
                "TARGETED_DEVICE_FAMILY" << "1,2",
                
                //--- Framework related:
                
                "DEFINES_MODULE" << "NO",
                "SKIP_INSTALL" << "YES"
            )
            
            //---
        
            t.unitTests { ut in
                
                ut.include("Tst")
                
                //---
                
                ut.configurations.all.override(
                
                    "PRODUCT_BUNDLE_IDENTIFIER" << "\(My.companyIdentifier).\(My.repoName).Tst",
                    "INFOPLIST_FILE" << "Info/Tst.plist",
                    "FRAMEWORK_SEARCH_PATHS" << "$(inherited) $(BUILT_PRODUCTS_DIR)"
                )
            }
        }
    }
]

import XCEProjectGenerator

//===

let params =
(
    repoName: "MyAwesomeFramework",
    deploymentTarget: "8.0",
    companyIdentifier: "khatskevich.maxim",
    developmentTeamId: "UJA88X59XP" // 'Maxim Khatskevich'
)

let bundleId =
(
    fwk: "\(params.companyIdentifier).\(params.repoName)",
    tst: "\(params.companyIdentifier).\(params.repoName).Tst"
)

let targetId =
(
    fwk: "Fwk",
    tst: "Tst"
)

//===

let specFormat = Spec.Format.v2_1_0

let project = Project(params.repoName) { project in
    
    project.configurations.all.override(
        
        "IPHONEOS_DEPLOYMENT_TARGET" <<< params.deploymentTarget, // bug wokraround
        
        "DEVELOPMENT_TEAM" <<< params.developmentTeamId,
        
        "SWIFT_VERSION" <<< "3.0",
        "VERSIONING_SYSTEM" <<< "apple-generic"
    )
    
    project.configurations.debug.override(
        
        "SWIFT_OPTIMIZATION_LEVEL" <<< "-Onone"
    )
    
    //---
    
    project.target(targetId.fwk, .iOS, .framework) { fwk in
        
        fwk.include("Src-Common")
        // see variants
        
        //---
        
        fwk.configurations.all.override(
            
            "IPHONEOS_DEPLOYMENT_TARGET" <<< params.deploymentTarget, // bug wokraround
        
            "PRODUCT_BUNDLE_IDENTIFIER" <<< bundleId.fwk,
            "INFOPLIST_FILE" <<< "Info/Fwk.plist",
            
            //--- iOS related:
            
            "SDKROOT" <<< "iphoneos",
            "TARGETED_DEVICE_FAMILY" <<< DeviceFamily.iOS.universal,
            
            //--- Framework related:
            
            "DEFINES_MODULE" <<< "NO",
            "SKIP_INSTALL" <<< "YES"
        )
        
        fwk.configurations.debug.override(
            
            "MTL_ENABLE_DEBUG_INFO" <<< true
        )
        
        //---
    
        fwk.unitTests(targetId.tst) { tst in
            
            tst.include("Tst-Common")
            // see variants
            
            //---
            
            tst.configurations.all.override(
                
                // very important for unit tests,
                // prevents the error when unit test do not start at all
                "LD_RUNPATH_SEARCH_PATHS" <<<
                "$(inherited) @executable_path/Frameworks @loader_path/Frameworks",
                
                "IPHONEOS_DEPLOYMENT_TARGET" <<< params.deploymentTarget, // bug wokraround
                
                "PRODUCT_BUNDLE_IDENTIFIER" <<< bundleId.tst,
                "INFOPLIST_FILE" <<< "Info/Tst.plist",
                "FRAMEWORK_SEARCH_PATHS" <<< "$(inherited) $(BUILT_PRODUCTS_DIR)"
            )
            
            tst.configurations.debug.override(
                
                "MTL_ENABLE_DEBUG_INFO" <<< true
            )
        }
    }
    
    //---
    
    project.variants = [
        
        Project.Variant("General") { (variant: inout Project.Variant) in
            
            variant.target(targetId.fwk) { fwk in
                
                fwk.include("Src")
                
                //---
                
                fwk.unitTests(targetId.tst) { tst in
                    
                    tst.include("Tst")
                }
            }
        }
        ,
        
        Project.Variant("SpecialEdition") { (variant: inout Project.Variant) in
            
            variant.target(targetId.fwk) { fwk in
                
                fwk.include("Src-Special")
                
                //---
                
                fwk.unitTests(targetId.tst) { tst in
                    
                    tst.include("Tst-Special")
                }
            }
        }
    ]
}

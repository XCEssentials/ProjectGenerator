//
//  Target.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/16/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

public
extension Project
{
    public
    struct Target
    {
        public
        let name: String
        
        public
        let platform: Platform
        
        public
        let type: InternalType
        
        //---
        
        public private(set)
        var includes: [String] = []
        
        public
        mutating
        func include(_ paths: String...)
        {
            includes.append(contentsOf: paths)
        }
        
        //---
        
        public private(set)
        var excludes: [String] = []
        
        public
        mutating
        func exclude(_ patterns: String...)
        {
            excludes.append(contentsOf: patterns)
        }
        
        //---
        
        public private(set)
        var i18nResources: [String] = []
        
        public
        mutating
        func i18nResource(_ paths: String...)
        {
            i18nResources.append(contentsOf: paths)
        }
        
        //---
        
        public
        var configurations: BuildConfiguration.StandardSet
        
        public
        var dependencies = Dependencies()
        
        public
        var scripts = Scripts()
        
        public
        var includeCocoapods = false
        
        //---
        
        public private(set)
        var tests: [Target] = []
        
        public
        mutating
        func unitTests(
            _ name: String = "Tests",
            _ configureTarget: (inout Target) -> Void
            )
        {
            var ut = Target(self.platform, name, .unitTest, configureTarget)
            
            ut.dependencies.otherTarget(self.name)
            
            //===
            
            tests.append(ut)
        }
        
        public
        mutating
        func uiTests(
            _ name: String = "UITests",
            _ configureTarget: (inout Target) -> Void
            )
        {
            var uit = Target(self.platform, name, .uiTest, configureTarget)
            
            uit.dependencies.otherTarget(self.name)
            
            //===
            
            tests.append(uit)
        }
        
        //---
        
        // internal
        init(
            _ platform: Platform,
            _ name: String,
            _ type: InternalType,
            _ configureTarget: (inout Target) -> Void
            )
        {
            self.name = name
            self.platform = platform
            self.type = type
            
            //---
            
            switch (platform, type)
            {
            case (.iOS, .framework):
                self.configurations =
                    (
                        BuildConfiguration.Defaults.iOS.base(
                            ["framework"]
                        ),
                        BuildConfiguration.Defaults.iOS.debug(
                            //
                        ),
                        BuildConfiguration.Defaults.iOS.release(
                            //
                        )
                )
                
            case (.iOS, .unitTest):
                self.configurations =
                    (
                        BuildConfiguration.Defaults.iOS.base(
                            ["bundle.unit-test"]
                        ),
                        BuildConfiguration.Defaults.iOS.debug(
                            //
                        ),
                        BuildConfiguration.Defaults.iOS.release(
                            //
                        )
                )
                
            default:
                self.configurations =
                    (
                        BuildConfiguration.Base(
                            //
                        ),
                        BuildConfiguration.Defaults.debug(
                            //
                        ),
                        BuildConfiguration.Defaults.release(
                            //
                        )
                )
            }
            
            //---
            
            configureTarget(&self)
        }
    }
}

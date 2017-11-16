//
//  Variant.swift
//  ProjectGenerator
//
//  Created by Maxim Khatskevich on 2017-09-13.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//


public
extension Project
{
    public
    struct Variant
    {
        public
        let name: String
        
        //---
        
        public
        init(_ name: String, _ configure: ((inout Project.Variant) -> Void)?)
        {
            self.name = name
            configure?(&self)
        }
        
        //---
        
        public private(set)
        var targets: [Target] = []
        
        public
        mutating
        func target(
            _ name: String,
            _ configureTarget: (inout Target) -> Void
            )
        {
            targets.append(Target(name, configureTarget))
        }
    }
}

//===

public
extension Project.Variant
{
    public
    struct Target
    {
        public
        final
        class BuildConfigurations
        {
            public
            var all = Project.Target.BuildConfiguration.Base()
            
            public
            var debug = Project.Target.BuildConfiguration(
                Project.BuildConfiguration.Defaults.iOS.debug().name
            )
            
            public
            var release = Project.Target.BuildConfiguration(
                Project.BuildConfiguration.Defaults.iOS.release().name
            )
        }
        
        //===

        public
        let name: String
        
        //===

        public private(set)
        var includes: [String] = []
        
        public
        mutating
        func include(_ paths: String...)
        {
            includes.append(contentsOf: paths)
        }
        
        //===

        public private(set)
        var excludes: [String] = []
        
        public
        mutating
        func exclude(_ patterns: String...)
        {
            excludes.append(contentsOf: patterns)
        }
        
        //===

        public
        var sourceOptions: [String: String] = [:]
        
        //===

        public private(set)
        var i18nResources: [String] = []
        
        public
        mutating
        func i18nResource(_ paths: String...)
        {
            i18nResources.append(contentsOf: paths)
        }
        
        //===

        public
        let configurations = Target.BuildConfigurations()
        
        public
        var dependencies = Project.Target.Dependencies()
        
        public
        var scripts = Project.Target.Scripts()
        
        public
        var includeCocoapods = false
        
        //===

        public private(set)
        var tests: [Target] = []
        
        public
        mutating
        func unitTests(
            _ name: String = "Tests",
            _ configureTarget: (inout Target) -> Void
            )
        {
            tests.append(Target(name, configureTarget))
        }
        
        public
        mutating
        func uiTests(
            _ name: String = "UITests",
            _ configureTarget: (inout Target) -> Void
            )
        {
            var uit = Target(name, configureTarget)
            
            uit.dependencies.otherTarget(self.name)
            
            //---
            
            tests.append(uit)
        }
        
        //===

        // internal
        init(
            _ name: String,
            _ configureTarget: (inout Target) -> Void
            )
        {
            self.name = name
            
            //---
            
            configureTarget(&self)
        }
    }
}

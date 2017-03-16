//
//  Project.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/15/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

struct BuildConfiguration
{
    struct Base
    {
        let profiles: [String]
        
        //===
        
        fileprivate
        init(_ profiles: [String] = [])
        {
            self.profiles = profiles
        }
        
        //===
        
        private(set)
        var sources: [String] = []
        
        mutating
        func source(_ filePaths: String...)
        {
            sources.append(contentsOf: filePaths)
        }
        
        mutating
        func source(_ filePaths: [String])
        {
            sources.append(contentsOf: filePaths)
        }
        
        //===
        
        private(set)
        var overrides: [KeyValuePair] = []
        
        mutating
        func override(_ pairs: KeyValuePair...)
        {
            overrides.append(contentsOf: pairs)
        }
        
        mutating
        func override(_ pairs: [KeyValuePair])
        {
            overrides.append(contentsOf: pairs)
        }
    }
    
    //---
    
    typealias StandardSet =
    (
        all: Base,
        debug: BuildConfiguration,
        release: BuildConfiguration
    )
    
    //---
    
    fileprivate
    enum InternalType: String
    {
        case
        debug,
        release
    }
    
    //---
    
    enum Defaults
    {
        static
        func debug(_ profiles: [String] = []) -> BuildConfiguration
        {
            return
                BuildConfiguration(
                    "Debug",
                    .debug,
                    profiles
                )
        }
        
        static
        func release(_ profiles: [String] = []) -> BuildConfiguration
        {
            return
                BuildConfiguration(
                    "Release",
                    .release,
                    profiles
            )
        }
        
        //---
        
        enum General
        {
            static
            func debug(_ profiles: [String] = []) -> BuildConfiguration
            {
                return
                    BuildConfiguration
                        .Defaults
                        .debug(["general:debug"] + profiles)
            }
            
            static
            func release(_ profiles: [String] = []) -> BuildConfiguration
            {
                return
                    BuildConfiguration
                        .Defaults
                        .release(["general:release"] + profiles)
            }
        }
        
        //---
        
        enum iOS
        {
            static
            func base(_ profiles: [String] = []) -> BuildConfiguration.Base
            {
                return
                    BuildConfiguration
                        .Base(["platform:ios"] + profiles)
            }
            
            static
            func debug(_ profiles: [String] = []) -> BuildConfiguration
            {
                return
                    BuildConfiguration
                        .Defaults
                        .debug(["ios:debug"] + profiles)
            }
            
            static
            func release(_ profiles: [String] = []) -> BuildConfiguration
            {
                return
                    BuildConfiguration
                        .Defaults
                        .release(["ios:release"] + profiles)
            }
        }
    }
    
    //---
    
    fileprivate
    let name: String
    
    fileprivate
    let type: InternalType
    
    fileprivate
    let profiles: [String]
    
    //---
    
    private(set)
    var sources: [String] = []
    
    mutating
    func source(_ filePaths: String...)
    {
        sources.append(contentsOf: filePaths)
    }
    
    mutating
    func source(_ filePaths: [String])
    {
        sources.append(contentsOf: filePaths)
    }
    
    //---
    
    private(set)
    var overrides: [KeyValuePair] = []
    
    mutating
    func override(_ pairs: KeyValuePair...)
    {
        overrides.append(contentsOf: pairs)
    }
    
    mutating
    func override(_ pairs: [KeyValuePair])
    {
        overrides.append(contentsOf: pairs)
    }
    
    //---
    
    fileprivate
    init(
        _ name: String,
        _ type: InternalType,
        _ profiles: [String] = []
        )
    {
        self.name = name
        self.type = type
        self.profiles = profiles
    }
}

//===

struct Project
{
    struct Target
    {
        enum InternalType: String
        {
            case
                app = ":application",
                framework = ":framework",
                dynamicLibrary = ":library.dynamic",
                staticLibrary = ":library.static",
                bundle = ":bundle",
                unitTest = ":bundle.unit-test",
                uiTest = ":bundle.ui-testing",
                appExtension = ":app-extension",
                tool = ":tool",
                watchApp = ":application.watchapp",
                watchApp2 = ":application.watchapp2",
                watchKitExtension = ":watchkit-extension",
                watchKit2Extension = ":watchkit2-extension",
                tvAppExtension = ":tv-app-extension",
                messagesApp = ":application.messages",
                appExtensionMessages = ":app-extension.messages",
                appExtensionMessagesStickers = ":app-extension.messages-sticker-pack",
                xpcService = ":xpc-service"
        }
        
        //---
        
        let name: String
        let platform: Platform
        let type: InternalType
        
        //---
        
        private(set)
        var includes: [String] = []
        
        mutating
        func include(_ paths: String...)
        {
            includes.append(contentsOf: paths)
        }
        
        //---
        
        private(set)
        var excludes: [String] = []
        
        mutating
        func exclude(_ patterns: String...)
        {
            excludes.append(contentsOf: patterns)
        }
        
        //---
        
        var configurations: BuildConfiguration.StandardSet
        
        //---
        
        private(set)
        var tests: [Target] = []
        
        mutating
        func unitTests(
            _ name: String = "Tests",
            _ configureTarget: (inout Target) -> Void
            )
        {
            tests
                .append(Target(self.platform, name, .unitTest, configureTarget))
        }
        
        mutating
        func uiTests(
            _ name: String = "UITests",
            _ configureTarget: (inout Target) -> Void
            )
        {
            tests
                .append(Target(self.platform, name, .uiTest, configureTarget))
        }
        
        //---
        
        fileprivate
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
    
    //---
    
    let name: String
    
    //---
    
    var configurations: BuildConfiguration.StandardSet =
    (
        BuildConfiguration.Base(
            // nothing on this level
        ),
        BuildConfiguration.Defaults.General.debug(
            //
        ),
        BuildConfiguration.Defaults.General.release(
            //
        )
    )
    
    var targets: [Target] = []
    
    //---
    
    init(
        _ name: String,
        _ configureProject: (inout Project) -> Void
        )
    {
        self.name = name
        
        //---
        
        configureProject(&self)
        
        //=== DEBUG ===
        
//        print("Base project overrides:")
//        _ = self.configurations.all.overrides.map { print($0) }
    }
    
    //===
    
    mutating
    func target(
        _ name: String,
        _ platform: Platform,
        _ type: Target.InternalType,
        _ configureTarget: (inout Target) -> Void
        )
    {
        targets
            .append(Target(platform, name, type, configureTarget))
    }
}

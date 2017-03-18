//
//  Spec.1.2.0.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/17/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

enum Spec_1_2_0
{
    static
    func generate(for p: Project) -> RawSpec
    {
        var result: RawSpec = []
        var idention: Int = 0
        
        //===
        
        result <<< (idention, "# generated with MKHProjGen")
        result <<< (idention, "# https://github.com/maximkhatskevich/MKHProjGen")
        
        //===
        
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#version-number
        
        result <<< (idention, "version: 1.2.0")
        
        //===
        
        result <<< process(&idention, p.configurations)
        
        //===
        
        result <<< process(&idention, p.targets)
        
        //===
        
        result <<< (idention, "variants:")
        
        idention += 1
        
        result <<< (idention, "$base:")
        
        idention += 1
        
        result <<< (idention, "abstract: true")
        
        idention -= 1
        
        result <<< (idention, "\(p.name):")
        
        idention -= 1
        
        //===
        
        return result
    }
    
    //===
    
    static
    func process(
        _ idention: inout Int,
        _ set: BuildConfiguration.StandardSet
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#configurations
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        result <<< (idention, "configurations:")
        
        //===
        
        idention += 1
        
        //===
        
        result <<< process(&idention, set.all, set.debug)
        result <<< process(&idention, set.all, set.release)
        
        //===
        
        idention -= 1
        
        //===
        
        return result
    }
    
    //===
    
    static
    func process(
        _ idention: inout Int,
        _ b: BuildConfiguration.Base,
        _ c: BuildConfiguration
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#configurations
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        result <<< (idention, "\(c.name):")
        
        //===
        
        idention += 1
        
        //===
        
        result <<< (idention, "type: \(c.type)")
        
        //===
        
        if
            let externalConfig = c.externalConfig
        {
            // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#xcconfig-references
            
            // NOTE: when using xcconfig files,
            // any overrides or profiles will be ignored.
            
            result <<< (idention, "source: \(externalConfig)")
        }
        else
        {
            // NO source/xcconfig provided
            
            //===
            
            // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#profiles
            
            result <<< (idention, "profiles:")
            
            for p in b.profiles + c.profiles
            {
                result <<< (idention, "- \(p)")
            }
            
            //===
            
            // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#overrides
            
            result <<< (idention, "overrides:")
            idention += 1
            
            for o in b.overrides + c.overrides
            {
                result <<< (idention, "\(o.key): \(o.value)")
            }
            
            idention -= 1
        }
        
        //===
        
        idention -= 1
        
        //===
        
        return result
    }
    
    //===
    
    static
    func process(
        _ idention: inout Int,
        _ targets: [Project.Target]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#targets
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        result <<< (idention, "targets:")
        
        //===
        
        idention += 1
        
        //===
        
        for t in targets
        {
            result <<< process(&idention, t)
            
            //===
            
            for tst in t.tests
            {
                result <<< process(&idention, tst)
            }
        }
        
        //===
        
        idention -= 1
        
        //===
        
        return result
    }
    
    //===
    
    static
    func process(
        _ idention: inout Int,
        _ t: Project.Target
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#targets
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        result <<< (idention, "\(t.name):")
        
        //===
        
        idention += 1
        
        //===
        
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#platform
        
        result <<< (idention, "platform: \(t.platform.rawValue)")
        
        //===
        
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#type
        
        result <<< (idention, "type: \"\(t.type.rawValue)\"")
        
        //===
        
        result <<< process(&idention, t.dependencies)
        
        //===
        
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#sources
        
        if
            !t.includes.isEmpty
        {
            result <<< (idention, "sources:")
            
            for path in t.includes
            {
                result <<< (idention, "- \(path)")
            }
        }
        
        //===
        
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#excludes
        
        if
            !t.excludes.isEmpty
        {
            result <<< (idention, "excludes:")
            idention += 1
            result <<< (idention, "files:")
            
            for path in t.excludes
            {
                result <<< (idention, "- \(path)")
            }
            
            idention -= 1
        }
        
        //===
        
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#i18n-resources
        
        if
            !t.i18nResources.isEmpty
        {
            result <<< (idention, "i18n-resources:")
            
            for path in t.i18nResources
            {
                result <<< (idention, "- \(path)")
            }
        }
        
        //===
        
        result <<< process(&idention, t.configurations)
        
        //===
        
        result <<< process(&idention, scripts: t.scripts)
        
        //===
        
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#cocoapods
        
        if
            t.includeCocoapods
        {
            result <<< (idention, "includes_cocoapods: \(t.includeCocoapods)")
        }
        
        //===
        
        idention -= 1
        
        //===
        
        return result
    }
    
    //===
    
    static
    func process(
        _ idention: inout Int,
        _ deps: Project.Target.Dependencies
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#references
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        if
            !deps.fromSDKs.isEmpty ||
            !deps.otherTargets.isEmpty ||
            !deps.binaries.isEmpty ||
            !deps.projects.isEmpty
        {
            result <<< (idention, "references:")
            
            //===
            
            result <<< processDependencies(&idention, fromSDK: deps.fromSDKs)
            result <<< processDependencies(&idention, targets: deps.otherTargets)
            result <<< processDependencies(&idention, binaries: deps.binaries)
            result <<< processDependencies(&idention, projects: deps.projects)
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func processDependencies(
        _ idention: inout Int,
        fromSDK: [String]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#references
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        for dep in fromSDK
        {
            result <<< (idention, "- sdkroot:\(dep)")
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func processDependencies(
        _ idention: inout Int,
        targets: [String]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#references
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        for t in targets
        {
            result <<< (idention, "- \(t)")
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func processDependencies(
        _ idention: inout Int,
        binaries: [Project.Target.BinaryDependency]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#references
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        for b in binaries
        {
            result <<< (idention, "- location: \(b.location)")
            result <<< (idention, "  codeSignOnCopy: \(b.codeSignOnCopy)")
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func processDependencies(
        _ idention: inout Int,
        projects: [Project.Target.ProjectDependencies]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#references
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        for p in projects
        {
            result <<< (idention, "- location: \(p.location)")
            result <<< (idention, "  frameworks:")
            
            for f in p.frameworks
            {
                result <<< (idention, "  - name: \(f.name)")
                result <<< (idention, "    copy: \(f.copy)")
                result <<< (idention, "    codeSignOnCopy: \(f.codeSignOnCopy)")
            }
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func process(
        _ idention: inout Int,
        scripts: Project.Target.Scripts
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#scripts
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        if
            !scripts.regulars.isEmpty ||
            !scripts.beforeBuilds.isEmpty ||
            !scripts.afterBuilds.isEmpty
        {
            result <<< (idention, "scripts:")
            
            //===
            
            idention += 1
            
            //===
            
            result <<< processScripts(&idention, regulars: scripts.regulars)
            result <<< processScripts(&idention, beforeBuild: scripts.beforeBuilds)
            result <<< processScripts(&idention, afterBuild: scripts.afterBuilds)
            
            //===
            
            idention -= 1
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func processScripts(
        _ idention: inout Int,
        regulars: [String]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#scripts
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        for s in regulars
        {
            result <<< (idention, "- \(s)")
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func processScripts(
        _ idention: inout Int,
        beforeBuild: [String]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#scripts
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        result <<< (idention, "prebuild:")
        
        for s in beforeBuild
        {
            result <<< (idention, "- \(s)")
        }
        
        //===
        
        return result
    }
    
    //===
    
    static
    func processScripts(
        _ idention: inout Int,
        afterBuild: [String]
        ) -> RawSpec
    {
        // https://github.com/lyptt/struct/wiki/Spec-format:-v1.2#scripts
        
        //===
        
        var result: RawSpec = []
        
        //===
        
        result <<< (idention, "postbuild:")
        
        for s in afterBuild
        {
            result <<< (idention, "- \(s)")
        }
        
        //===
        
        return result
    }
}

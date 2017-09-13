//
//  Project.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/15/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

public
struct Project
{
    public
    final
    class BuildConfigurations
    {
        public
        var all = BuildConfiguration.Base()
        
        public
        var debug = BuildConfiguration.Defaults.General.debug()
        
        public
        var release = BuildConfiguration.Defaults.General.release()
    }
    
    //---
    
    public
    let name: String
    
    //---
    
    public
    let configurations = BuildConfigurations()
    
    public private(set)
    var targets: [Target] = []
    
    //---
    
    public
    init(
        _ name: String,
        _ configureProject: (inout Project) -> Void
        )
    {
        self.name = name
        
        //---
        
        configureProject(&self)
    }
    
    //===
    
    public
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
    
    //===
    
    public
    var variants: [Project.Variant] = []
}

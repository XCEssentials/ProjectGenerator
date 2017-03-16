//
//  BuildConfig.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/16/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

public
struct BuildConfiguration
{
    public
    let name: String
    
    public
    let type: InternalType
    
    public
    let profiles: [String]
    
    //---
    
    public private(set)
    var sources: [String] = []
    
    public
    mutating
    func source(_ filePaths: String...)
    {
        sources.append(contentsOf: filePaths)
    }
    
    public
    mutating
    func source(_ filePaths: [String])
    {
        sources.append(contentsOf: filePaths)
    }
    
    //---
    
    public private(set)
    var overrides: [KeyValuePair] = []
    
    public
    mutating
    func override(_ pairs: KeyValuePair...)
    {
        overrides.append(contentsOf: pairs)
    }
    
    public
    mutating
    func override(_ pairs: [KeyValuePair])
    {
        overrides.append(contentsOf: pairs)
    }
    
    //---
    
    // internal
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

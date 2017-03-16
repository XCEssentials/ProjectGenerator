//
//  BuildConfig.Base.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/16/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

public
extension BuildConfiguration
{
    public
    struct Base
    {
        public
        let profiles: [String]
        
        //===
        
        // internal
        init(_ profiles: [String] = [])
        {
            self.profiles = profiles
        }
        
        //===
        
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
        
        //===
        
        public private(set)
        var overrides: [KeyValuePair] = []
        
        public
        mutating
        func override(_ pairs: KeyValuePair...)
        {
            overrides.append(contentsOf: pairs)
        }
        
//        public
//        mutating
//        func override(_ pairs: [KeyValuePair])
//        {
//            overrides.append(contentsOf: pairs)
//        }
    }
}

//
//  BuildConfig.Defaults.iOS.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/16/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

extension BuildConfiguration.Defaults
{
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

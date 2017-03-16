//
//  BuildConfig.Defaults.General.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/16/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

extension BuildConfiguration.Defaults
{
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
}

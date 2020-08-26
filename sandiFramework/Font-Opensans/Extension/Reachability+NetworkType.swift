//
//  Reachability+NetworkType.swift
//  SpeedTest_sji
//
//  Created by adriansalim on 24/04/20.
//  Copyright © 2020 sample. All rights reserved.
//

import Reachability
import CoreTelephony

enum NetworkType {
    case unknown
    case noConnection
    case wifi
    case wwan2g
    case wwan3g
    case wwan4g
    case unknownTechnology(name: String)
}

extension Reachability {
    
    public static func getNetworkType() -> String {
        guard let reachability: Reachability = Reachability() else { return "Unknown" }
        do {
            try reachability.startNotifier()
            switch reachability.connection {
            case .none:     return "No Connection"
            case .wifi: return "Wifi"
            case .cellular: return Reachability.getWWANNetworkType()
            }
        } catch {
            return "Unknown"
        }
    }
    
    public static func getWWANNetworkType() -> String {
        guard let currentRadioAccessTechnology = CTTelephonyNetworkInfo().currentRadioAccessTechnology else { return "Unknown" }
        switch currentRadioAccessTechnology {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x:
            return "2g"
        case CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB,
             CTRadioAccessTechnologyeHRPD:
            return "3g"
        case CTRadioAccessTechnologyLTE:
            return "4g"
        default:
            return "Unknown"
        }
    }
    
}


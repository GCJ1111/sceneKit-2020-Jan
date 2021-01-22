//
//  utils.swift
//  SceKit-Axis
//
//  Created by 龚晨杰 on 2020/11/26.
//

import Foundation
import SceneKit

func nodeSetScaleAll(withNode node:SCNNode, factor:Double) {

    node.scale = SCNVector3(factor, factor, factor)

}

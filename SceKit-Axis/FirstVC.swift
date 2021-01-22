//
//  firstVC.swift
//  SceKit-Axis
//
//  Created by 龚晨杰 on 2020/11/26.
//




import UIKit
import SceneKit

class FirstVC: UIViewController  {

    var scene:SCNScene?
    override func viewDidLoad() {
        super.viewDidLoad()

        print("FirstVC did loaded")
        scene = SCNScene(named: "art.scnassets/empty.scn")
        initScnView()

        setupCamera()
        
        setupCordinator(forAxis:  0)
        setupCordinator(forAxis:  1)
        
        let savePath = URL(fileURLWithPath: "/Users/gongchenjie/Documents/IOS-temp/3D/SceKit-Axis-Axis-2/SceKit-Axis/output_scene/twoD-axis.scn")

        scene?.write(to: savePath, options: nil, delegate: nil, progressHandler: nil)
    }
    
    
    /// 初始化 scnView
    func initScnView(){
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        // set the scene to the view
        scnView.scene = scene
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
    }


    
    /// 创建坐标轴
    /// - Parameter asix: 0 - x axis
    ///                   1 - z axis
    
    func setupCordinator(forAxis axis:Int){
        let textNode_tmplt = SCNNode()

        
        for i in stride( from : -100 , through : 100 ,  by : 0.5){
//          print(i)

            let textNode = textNode_tmplt.clone()
            let textContent = SCNText(string: i.description, extrusionDepth: 0.3)
            textNode.geometry = textContent
            
            // 设置 字体的 缩放大小
//            nodeSetScaleAll(withNode: textNode, factor: 0.3)
            textContent.font = UIFont.systemFont(ofSize: 0.5)

            // 设置材质的通用 属性
            let m2 = SCNMaterial()
            textContent.firstMaterial = m2


            if (axis == 0) {
                textNode.position = SCNVector3(i, 0.0, 0.0)
//                textNode.orientation = SCNVector4(-90, 0.0, 0.0, 0.0)
                textNode.eulerAngles = SCNVector3(-90, 0, 0.0)
                textNode.name = "X-" + i.description

                m2.diffuse.contents = UIColor.init(cgColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
            }
            else if (axis == 1){
                textNode.position = SCNVector3(0.0, 0.0, i)
                m2.diffuse.contents = UIColor.init(cgColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                textNode.name = "Y-" + i.description

            } else {
                print("axis not found , please input 0 or 1.")
            }
            scene?.rootNode.addChildNode(textNode)

        }
    }
    
    func setupCamera() {
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene?.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 10, y: 10, z: -10)
        
        cameraNode.look(at: SCNVector3(0,0,0))
    }

}


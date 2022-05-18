//
//  GameScene.swift
//  SideScrollerGame
//
//  Created by ELLA MADALINSKI on 5/3/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var ball : SKSpriteNode!
    let cam = SKCameraNode()
    var score : SKLabelNode!
    var scoreNum = 0
    var ballPositionX : CGFloat? = nil
    var ballPositionY : CGFloat? = nil
    
    override func sceneDidLoad() {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        score = self.childNode(withName: "scoreLabel") as! SKLabelNode
        self.camera = cam
        physicsWorld.contactDelegate = self
        score.text = "0"
        ballPositionX = ball.position.x
        ballPositionY = ball.position.y
        print(ballPositionX)
        print(ballPositionY)
    }
 
    override func update(_ currentTime: TimeInterval) {
        cam.position = ball.position
        score.position = CGPoint(x: ball.position.x, y: ball.position.y + 60.0)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("collision happened")
        if contact.bodyA.node?.name == "bad" || contact.bodyB.node?.name == "bad"{
            scoreNum -= 1
            score.text = "\(scoreNum)"
        }
        
        if contact.bodyA.node?.name == "good" || contact.bodyB.node?.name == "good"{
            scoreNum += 1
            score.text = "\(scoreNum)"
        }
        
    }
    
    func jump(){
        if ball.physicsBody?.allContactedBodies() != [] {
            ball.physicsBody?.velocity = CGVector(dx: 500, dy: 1000)
        }
    }
    
    func restart(){
        ball.position = CGPoint(x: ballPositionX!, y:  ballPositionY!)
        scoreNum = 0
        score.text = "0"
        ball.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
    }
    
}

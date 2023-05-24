//
//  ContentView.swift
//  SpaceShooter
//
//  Created by Vicky Irwanto on 24/05/23.
//

import SwiftUI
import SpriteKit
import GameKit

class GameScene: SKScene, SKPhysicsContactDelegate, ObservableObject{
    let background = SKSpriteNode(imageNamed: "bg")
    var player = SKSpriteNode()
    var playerFire = SKSpriteNode()
    var fireTimer = Timer()
    var enemyTimer = Timer()
    var enemy = SKSpriteNode()
    
    @Published var gameOver = false
    
    var liveArray = [SKSpriteNode]()
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    struct CBitmask{
        static let playerShip: UInt32 = 0b1
        static let playerFire: UInt32 = 0b10
        static let enemyShip: UInt32 = 0b100
        static let bossOne: UInt32 = 0b1000
    }
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        scene?.size = CGSize(width: 750, height: 1335)
        
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.setScale(0.59)
        background.zPosition = 1
        addChild(background)
        makePlayer(playerCh: shipChoice.integer(forKey: "playerChoice"))
        
        fireTimer = .scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(playerFireAction), userInfo: nil, repeats: true)
        
        enemyTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(makeEnemys), userInfo: nil, repeats: true)
        
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = .red
        scoreLabel.zPosition = 10
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height/1.15)
        addChild(scoreLabel)
        addLives(lives: 3)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA : SKPhysicsBody
        let contactB : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            contactA = contact.bodyA
            contactB = contact.bodyB
        }else{
            contactA = contact.bodyB
            contactB = contact.bodyA
        }
        
//        PlayerFire Hit Enemy
        if contactA.categoryBitMask == CBitmask.playerFire && contactB.categoryBitMask == CBitmask.enemyShip{
            updateScore()
            
            playerFireHitEnemy(fires: contactA.node as! SKSpriteNode, enemys: contactB.node as! SKSpriteNode)
        }
        
//        enemy hit player
        if contactA.categoryBitMask == CBitmask.playerShip && contactB.categoryBitMask == CBitmask.enemyShip{
            
            player.run(SKAction.repeat(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.fadeIn(withDuration: 0.1)]), count: 8))
            
            if let live1 = childNode(withName: "live1"){
                live1.removeFromParent()
            }else if let live2 =  childNode(withName: "live2"){
                live2.removeFromParent()
            }else if let live3 = childNode(withName: "live3"){
                live3.removeFromParent()
                player.removeFromParent()
                fireTimer.invalidate()
                enemyTimer.invalidate()
                SoundManager.instance.StopSoundFire()
                gameOverFunc()
            }
            
//            playerHitEnemy(players: contactA.node as! SKSpriteNode, enemys: contactB.node as! SKSpriteNode)
        }
    }
    
    func playerHitEnemy(players: SKSpriteNode, enemys: SKSpriteNode){
        players.removeFromParent()
        enemys.removeFromParent()
        
        fireTimer.invalidate()
        enemyTimer.invalidate()
        
        let explo = SKEmitterNode(fileNamed: "ExplosionOne")
        explo?.position = players.position
        explo?.zPosition = 5
        addChild(explo!)
    }
    
    func playerFireHitEnemy(fires: SKSpriteNode, enemys: SKSpriteNode){
        fires.removeFromParent()
        enemys.removeFromParent()
        
        let explo = SKEmitterNode(fileNamed: "ExplosionOne")
        explo?.position = enemys.position
        explo?.zPosition = 5
        addChild(explo!)
    }
    
    func addLives(lives: Int){
        for i in 1...lives{
            let live = SKSpriteNode(imageNamed: "health")
            live.setScale(0.1)
            live.position = CGPoint(x: CGFloat(i)*live.size.width+10, y: size.height - live.size.height-10)
            live.zPosition = 10
            live.name = "live\(i)"
            liveArray.append(live)
            
            addChild(live)
        }
    }
    
    func makePlayer(playerCh: Int){
        var shipName = ""
        
        switch playerCh{
        case 1:
            shipName = "ship1"
        case 2:
            shipName = "ship2"
        case 3:
            shipName = "ship3"
        default:
            shipName = "ship1"
        }
        
        player = .init(imageNamed: shipName)
        player.position = CGPoint(x: size.width/2, y: 120)
        player.zPosition = 10
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = CBitmask.playerShip
        player.physicsBody?.contactTestBitMask = CBitmask.enemyShip
        player.physicsBody?.collisionBitMask = CBitmask.enemyShip
        player.setScale(0.7)
        addChild(player)
    }
    
    @objc func playerFireAction(){
        playerFire = .init(imageNamed: "amunition")
        playerFire.position = player.position
        playerFire.zPosition = 3
        playerFire.physicsBody = SKPhysicsBody(rectangleOf: playerFire.size)
        playerFire.physicsBody?.affectedByGravity = false
        playerFire.physicsBody?.categoryBitMask = CBitmask.playerFire
        playerFire.physicsBody?.contactTestBitMask = CBitmask.enemyShip
        playerFire.physicsBody?.collisionBitMask = CBitmask.enemyShip
        addChild(playerFire)
        
        let moveAction = SKAction.moveTo(y: 1400, duration: 1)
        let delateAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction, delateAction])
        
        SoundManager.instance.PlaySoundFire()
        playerFire.run(combine)
    }
    
    @objc func makeEnemys(){
        let randomNumber = GKRandomDistribution(lowestValue: 50, highestValue: 700)
        enemy = .init(imageNamed: "meteor")
        enemy.position = CGPoint(x: randomNumber.nextInt(), y: 1400)
        enemy.zPosition = 5
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = CBitmask.enemyShip
        enemy.physicsBody?.contactTestBitMask = CBitmask.playerShip | CBitmask.playerFire
        enemy.physicsBody?.collisionBitMask = CBitmask.playerShip | CBitmask.playerFire
        addChild(enemy)
        
        let moveAction = SKAction.moveTo(y: -100, duration: 2)
        let deletaAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction, deletaAction])
        
        enemy.run(combine)
        
        
    }
    
    func updateScore(){
        score += 1
        
        scoreLabel.text = "Score: \(score)"
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
        }
    }
    
    func gameOverFunc(){
        removeAllChildren()
        gameOver = true
        
        let gameOverLabel =  SKLabelNode()
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 90
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/1.9)
        gameOverLabel.fontColor = UIColor.red
        
        addChild(gameOverLabel)
    }
}

struct ContentView: View {
   @ObservedObject var scene = GameScene()
    
    var body: some View {
        NavigationView{
            HStack{
                ZStack{
                    SpriteView(scene: scene)
                        .ignoresSafeArea()
                    
                    if scene.gameOver == true{
                        NavigationLink{
                            HomeView().navigationBarHidden(true).navigationBarBackButtonHidden(true)
                        }label: {
                            Text("Back To Start")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    
                    
                }
            }
            
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

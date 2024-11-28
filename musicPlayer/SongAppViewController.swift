

import UIKit
import AVFoundation

class playSongViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var singerLabel: UILabel!
    
    @IBOutlet weak var timeDurationLabel: UILabel!
    
    @IBOutlet weak var remainDurationLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var playBackwardButton: UIButton!
    
    @IBOutlet weak var playForwardButton: UIButton!
    
    @IBOutlet weak var currentTimeSlider: UISlider!
    
    @IBOutlet weak var lowVolumeSpeakerImageView: UIImageView!
    
    @IBOutlet weak var highVolumeSpeakerImageView: UIImageView!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var shuffleButton: UIButton!
    
    var player = AVPlayer()
    var index = 0
    var shuffledIndex = 0
    let songLists = [
        song(
            songName: "頌",
            singer: "鹿洐人 HumanHart",
            cover: "頌",
            backgroundColor: [CGColor(red: 47/255, green: 60/255, blue: 24/255, alpha: 1),CGColor(red: 17/255, green: 22/255, blue: 9/255, alpha: 1)]),
        song(
            songName: "混蛋使徒",
            singer: "鹿洐人 HumanHart",
            cover: "輸出368",
            backgroundColor: [ CGColor(red: 30/255, green: 36/255, blue: 48/255, alpha: 1), CGColor(red: 10/255, green: 13/255, blue: 17/255, alpha: 1) ]),
        song(
            songName: "極端理想",
            singer: "鹿洐人 HumanHart",
            cover: "輸出479",
            backgroundColor: [CGColor(red: 161/255, green: 53/255, blue: 54/255, alpha: 1), CGColor(red: 59/255, green: 20/255, blue: 20/255, alpha: 1)]),
        song(
            songName: "Carry On",
            singer: "鹿洐人 HumanHart",
            cover: "你在開玩笑嗎？",
            backgroundColor: [CGColor(red: 184/255, green: 83/255, blue: 36/255, alpha: 1), CGColor(red: 68/255, green: 30/255, blue: 13/255, alpha: 1)]),
        ]
    var shuffledSongList:[song]!
    var playerItem:AVPlayerItem!
    var gradientLayer = CAGradientLayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置背景漸層
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 封面圓角
        coverImageView.layer.cornerRadius = 20
        coverImageView.layer.masksToBounds = true
        
        // 歌手與歌曲標籤樣式
        singerLabel.font = UIFont.systemFont(ofSize: 15)
        singerLabel.textColor = UIColor(red: 186/255, green: 189/255, blue: 182/255, alpha: 1)
        songNameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        songNameLabel.textColor = .white
        
        // 時間標籤顏色
        remainDurationLabel.textColor = .white
        timeDurationLabel.textColor = .white
        
        // 播放鍵樣式
        playButton.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 50)
        playButton.configuration?.baseForegroundColor = .white
        playForwardButton.configuration?.baseForegroundColor = .white
        playBackwardButton.configuration?.baseForegroundColor = .white
        
        // 音量圖示顏色
        lowVolumeSpeakerImageView.tintColor = .white
        highVolumeSpeakerImageView.tintColor = .white
        shuffleButton.tintColor = .white
        
        // 初始化播放資訊與功能
        songInfo()
        songDurationSetting()
        playSongAutomatically()
        
        // 滑桿樣式
        let sliderImage = UIImage(systemName: "circlebadge.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        volumeSlider.setThumbImage(sliderImage, for: .normal)
        volumeSlider.tintColor = .white
        currentTimeSlider.setThumbImage(sliderImage, for: .normal)
        currentTimeSlider.tintColor = .white
    }

    
    func songInfo(){
        //建立歌曲位置
        let url = Bundle.main.url(forResource: songLists[index].songName, withExtension: "mp3")!
        //將歌曲位置登入至AVPlayerItem
        playerItem = AVPlayerItem(url: url)
        //將AVPlayerItem傳入player使player有播放物件
        player.replaceCurrentItem(with: playerItem)
        //更改封面
        coverImageView.image = UIImage(named: songLists[index].cover)
        //更改歌名文字
        songNameLabel.text = songLists[index].songName
        //更改歌手名字
        singerLabel.text = songLists[index].singer
        //更改背景
        gradientLayer.colors = songLists[index].backgroundColor
    }
    func shuffledSongInfo(){
        //建立歌曲位置
        let url = Bundle.main.url(forResource: shuffledSongList[shuffledIndex].songName, withExtension: "mp3")!
        //將歌曲位置登入至AVPlayerItem
        playerItem = AVPlayerItem(url: url)
        //將AVPlayerItem傳入player使player有播放物件
        player.replaceCurrentItem(with: playerItem)
        //更改封面
        coverImageView.image = UIImage(named: shuffledSongList[shuffledIndex].cover)
        //更改歌名文字
        songNameLabel.text = shuffledSongList[shuffledIndex].songName
        //更改歌手名字
        singerLabel.text = shuffledSongList[shuffledIndex].singer
        //更改背景
        gradientLayer.colors = shuffledSongList[shuffledIndex].backgroundColor
    }
    //播完後自動播放
    func playSongAutomatically(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
            if self.isShuffle == true{
                self.shuffledIndex = (self.shuffledIndex + 1) % self.shuffledSongList.count
                self.shuffledSongInfo()
            }else{
                self.index = ( self.index + 1) %  self.songLists.count
                self.songInfo()
            }
            self.player.play()
        }
    }
    
    //獲取歌曲時間
    func songDurationSetting(){
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main) {
            _ in
            if self.player.timeControlStatus == .playing {
                //已播時間
                //現在的時間
                let currentTime = self.player.currentTime()
                //轉成總秒數後，將總秒數轉成Int
                let seconds = Int(CMTimeGetSeconds(currentTime))
                //將總秒數換算成秒數
                let secondText = String(format: "%02d", seconds % 60)
                //將總秒數換算成分鐘數
                let minuteText = String(seconds / 60)
                //顯示在Label上
                self.timeDurationLabel.text = "\(minuteText):\(secondText)"
                
                //剩餘時間
                //得到目前歌曲的總時間(總秒數)
                let songDuration = self.playerItem.asset.duration.seconds
                //將總秒數變成Int
                let durationSecs = Int(songDuration)
                //總秒數-已播秒數=剩餘秒數
                let remainSecs = durationSecs - seconds
                //換算成秒數
                let remainSecText = String(format: "%02d", Int(remainSecs)%60)
                //換算成分鐘數
                let remainMinText = String(Int(remainSecs)/60)
                //顯示在Label上
                self.remainDurationLabel.text = "-\(remainMinText):\(remainSecText)"
                //將目前歌曲的總秒數設成slider的最大值
                self.currentTimeSlider.maximumValue = Float(songDuration)
                //slider的值為目前歌曲的已播秒數
                self.currentTimeSlider.value = Float(seconds)
                
            }else{
                print("not playing")
            }
        }
    }
   
   
    //播放音樂
    //UIImage的name參數要使用systemName而不是named，這樣才能顯示系統內建的圖片
    @IBAction func playButton(_ sender: UIButton) {
        if player.timeControlStatus == .playing{
            sender.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            player.pause()
        }else{
            sender.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            player.play()
        }
    }
    
    @IBAction func playForward(_ sender: Any) {
        
        if isShuffle == true{
            shuffledIndex = (shuffledIndex + 1) % shuffledSongList.count
            shuffledSongInfo()
            print(shuffledIndex)
        }else{
            index = (index + 1) % songLists.count
            songInfo()
            print(index)
        }
    }
    
    @IBAction func playBackward(_ sender: Any) {
        
        if isShuffle == true{
            shuffledIndex = (shuffledIndex - 1 + shuffledSongList.count) % shuffledSongList.count
            shuffledSongInfo()
            print(shuffledIndex)
        }else{
            index = (index - 1 + songLists.count) % songLists.count
            songInfo()
            print(index)
        }
    }
    
    
    @IBAction func timeDurationSlider(_ sender: UISlider) {
        let currentSecs = Int64(sender.value)
        let targetTime = CMTimeMake(value: currentSecs, timescale: 1)
        player.seek(to: targetTime)
    }
    
    //控制音量
    @IBAction func volumeSlider(_ sender: UISlider) {
        player.volume = Float(sender.value)
    }
    
    //隨機播放
    var isShuffle = false
    @IBAction func shuffleBtn(_ sender: UIButton) {
        if isShuffle == true{
            sender.configuration?.baseForegroundColor = .white
            isShuffle = false
        }else{
            shuffledSongList = songLists.shuffled()
            sender.configuration?.baseForegroundColor = .green
            isShuffle = true
        }
    }
}

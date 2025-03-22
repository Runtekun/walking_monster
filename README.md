# walking-monster

# ■ サービス概要                                                               

「ウォーキングを楽しく継続できる」をテーマに walking-monsterは、歩数に応じてモンスターを育成することができる、ウォーキングしながらでも楽しめるwebアプリです。歩くことでモンスターが成長し、健康促進と育成系ゲームが融合した体験を提供します。

# ■ このサービスへの思い・作りたい理由                                                                
私自身、運動不足のため毎日ウォーキングに取り組んでいます。しかし、うまくモチベーションに繋げることができず、運動習慣を継続するのが大変でした。
そこで、歩くことを楽しみながらでも育成できる新しい体験を提供することで、今よりももっと楽しくウォーキングを継続できるのではないかという思いからこのサービスにしました。

# ■ ユーザー層について

ウォーキングを楽しく継続させることを目標に、毎日ウォーキングに取り組んでいる人やこれから始める方にこのwebアプリを触っていただけると幸いです。

# ■ サービスの利用イメージ

●ユーザー登録

まず、ユーザー登録を行います。

●モンスターの選択

最初に3体のモンスターの中から、お気に入りの1体を選びます。このモンスターがあなたのパートナーとなります。

●歩行距離に応じたモンスター育成

目標の歩行距離を設定し、歩行距離に応じてモンスターが獲得する経験値が増加していきます。100mごとに10XP(経験値)獲得し、累積XP(経験値)が一定値に達すると、モンスターがレベルアップします。

●進化システム

モンスターのレベルが一定値に達すると、新たな姿に進化することが可能です。進化すると、見た目が変化します。

このように、歩くことを楽しみながらモンスターを育てることができ、運動のモチベーションを楽しく維持できる新しい体験が得られます。

# ■ ユーザーの獲得について

X、イベント等で宣伝

# ■ サービスの差別化ポイント・推しポイント

歩行距離に応じてモンスターを育成することができる。

# ■ 機能候補                                                             

MVPリリース

●検索機能

●ログイン・ログアウト機能

●アカウント登録機能

●プロフィール機能

●プロフィール編集機能

●目標歩行距離登録・編集機能(ユーザーが出発地点から目的地までの歩行距離を登録・編集できる)

●コメント機能

●画像アップロード機能

●いいね機能

●投稿機能

●モンスター育成機能

本リリース

●歩行距離取得機能(徒歩での移動距離を計測)

●ランキング機能 

●デイリーミッション

デイリースタンプ機能

# ■ 機能の実装方針予定

●ログイン・ログアウト機能、アカウント登録、プロフィール編集機能 (devise) 

●画像アップロード機能 (ImageMagick)

●目標歩行距離登録・編集機能、歩行距離取得機能 (Google Maps Platform)
Directions APIを使用予定

●デイリーミッション (sidekiq-cron)

●デイリースタンプ機能 (activerecord-session_store)

### 画面遷移図
Figma：https://www.figma.com/design/JiPk10bdxLpIveqGIAS5tk/%E5%8D%92%E6%A5%AD%E5%88%B6%E4%BD%9C-%3A-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&p=f&t=GfeuYno0mUICyWVy-0

# ER図

![alt text](<ER図 MVPリリース.PNG>)
-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (x86_64)
--
-- Host: localhost    Database: wespace
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `FACILITIES`
--

DROP TABLE IF EXISTS `FACILITIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES` (
  `FACILITIES_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地ID',
  `FACILITIES_NAME` varchar(50) DEFAULT NULL COMMENT '場地名稱',
  `FACILITIES_RULES` longtext COMMENT '場地規範',
  `FACILITIES_CANCELLATION_POLICY` longtext COMMENT '場地退費資訊',
  `FACILITIES_CITY` varchar(200) DEFAULT NULL COMMENT '場地所在城市',
  `FACILITIES_TOWN` varchar(200) DEFAULT NULL COMMENT '場地所在地區',
  `FACILITIES_ADDRESS` varchar(200) DEFAULT NULL COMMENT '場地地址',
  `FACILITIES_BYTRAIN` varchar(200) DEFAULT NULL COMMENT '搭捷運',
  `FACILITIES_BYBUS` varchar(200) DEFAULT NULL COMMENT '搭公車',
  `FACILITIES_BYCAR` varchar(200) DEFAULT NULL COMMENT '搭汽車',
  `FACILITIES_SIZE` int DEFAULT NULL COMMENT '場地大小',
  `FACILITIES_GUESTS` int DEFAULT NULL COMMENT '場地容納人數',
  `FACILITIES_OWNER_ID` int DEFAULT NULL COMMENT '場地管理者',
  `FACILITIES_STATUS` int DEFAULT NULL COMMENT '場地狀態',
  `MEMBER_ID` int DEFAULT NULL COMMENT '建立者會員ID',
  `FACILITIES_MIN_BUDGET` decimal(8,1) DEFAULT NULL COMMENT '場地最低價格',
  `FACILITIES_MAX_BUDGET` decimal(8,1) DEFAULT NULL COMMENT '場地最高價格',
  `FACILITIES_START_TIME` varchar(20) DEFAULT NULL COMMENT '場地最早開放時間',
  `FACILITIES_CLOSE_TIME` varchar(20) DEFAULT NULL COMMENT '場地最晚關閉時間',
  `FACILITIES_MIN_OPENING_DAY` int DEFAULT NULL COMMENT '場地最早開放日',
  `FACILITIES_MAX_OPENING_DAY` int DEFAULT NULL COMMENT '場地最晚開放日',
  PRIMARY KEY (`FACILITIES_ID`),
  KEY `FACILITIES_FACILITIES_OWNER_ID_FK` (`FACILITIES_OWNER_ID`),
  KEY `FACILITIES_MEMBER_ID_FK` (`MEMBER_ID`),
  CONSTRAINT `FACILITIES_FACILITIES_OWNER_ID_FK` FOREIGN KEY (`FACILITIES_OWNER_ID`) REFERENCES `FACILITIES_OWNER` (`FACILITIES_OWNER_ID`),
  CONSTRAINT `FACILITIES_MEMBER_ID_FK` FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER` (`MEMBER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES`
--

LOCK TABLES `FACILITIES` WRITE;
/*!40000 ALTER TABLE `FACILITIES` DISABLE KEYS */;
INSERT INTO `FACILITIES` VALUES (1,'HOWSHOW | 中山國小(台北) ','因應疫情以及配合政府政策，請注意：\r\n\r\n▲進入空間前須掃描現場實聯制QR CODE\r\n\r\n▲活動全程配戴口罩\r\n\r\n▲室內座位請採用梅花座，維持一公尺以上之距離\r\n\r\n• 遵守大樓規範，公共區域應保持輕聲細語，請勿大聲喧嘩。\r\n\r\n• 本場地設有監視器，僅供為確保場地使用狀況與財產安全，不會做其他用途使用。\r\n\r\n• 預約完成後，「門鎖密碼」將於活動當日寄送到您的信箱郵件，請自行查看並輸入以進入空間。\r\n\r\n• 使用後自行清潔環境，愛惜空間內所有裝潢設備。若您留下髒亂的環境或造成家具損毀，需額外支付清潔維護費用。\r\n\r\n• 請配合準時離場，不得提早進入或超時使用。\r\n\r\n• 不可烹飪或使用明火之加熱設備。\r\n\r\n• 不可使用麥克風及其他擴音設備。\r\n\r\n• 不可將空間內家具搬離空間。\r\n\r\n• 除等待進入外，不得逗留或佔用公共空間。\r\n\r\n• 不可攜帶寵物入內（導盲犬則不在此限）。\r\n\r\n• 嚴禁吸菸、毒品、性愛、攜帶危險物品，以及賭博等違反法令規定、公共秩序或善良風俗的行為。\r\n\r\n• 由於使用者的故意或過失，導致場地遭受損害時，WeSpace 將向該使用者要求賠償。','使用的 48 小時前，提供無條件免費更改訂單的服務，內容包含：「取消退費」、「改期」、「延長縮短時間」、「更改空間」。詳請請聯繫 WeSpace 的官方 Line 帳號 (ID: @wespace)','臺北市','大安區','新生北路三段84巷36號','「中山國小」站1號出口，步行 6 分鐘','「景福宮」站，步行 4 分鐘','「新生高架停車場」，步行 3 分鐘',13,20,1,0,2,450.0,450.0,'7','23',1,6),(2,'古亭六號01空間','因應疫情以及配合政府政策，請注意：\r\n\r\n▲ 活動全程配戴口罩\r\n\r\n• 遵守大樓規範，公共區域應保持輕聲細語，請勿大聲喧嘩。\r\n\r\n• 使用後自行清潔環境，愛惜空間內所有裝潢設備。若您留下髒亂的環境或造成家具損毀，需額外支付清潔維護費用。\r\n\r\n• 請配合準時離場，不得提早進入或超時使用。\r\n\r\n• 不可烹飪或使用明火之加熱設備。\r\n\r\n• 不可使用麥克風及其他擴音設備。\r\n\r\n• 不可將空間內家具搬離空間。\r\n\r\n• 除等待進入外，不得逗留或佔用公共空間。\r\n\r\n• 不可攜帶寵物入內（導盲犬則不在此限）。\r\n\r\n• 嚴禁吸菸、毒品、性愛、攜帶危險物品，以及賭博等違反法令規定、公共秩序或善良風俗的行為。\r\n\r\n• 由於使用者的故意或過失，導致場地遭受損害時，WeSpace 將向該使用者要求賠償。','使用的 48 小時前，提供無條件免費更改訂單的服務，內容包含：「取消退費」、「改期」、「延長縮短時間」、「更改空間」。詳請請聯繫 WeSpace 的官方 Line 帳號 (ID: @wespace)','臺北市','大安區','羅斯福路二段33號12 樓','「捷運古亭站」6號出口步行 30 秒','「福州街口」站，步行 4 分鐘','「和平一五停車場」步行 2 分鐘，費用依其規定。',4,7,2,0,2,250.0,250.0,'8','22',2,7),(3,'Not Only Cafe','• 平日早上及下午目前八折優惠中！\r\n\r\n• 現場「無」垃圾桶，請客戶可自備垃圾袋將垃圾帶走。\r\n\r\n• 使用後自行清潔環境，愛惜空間內所有裝潢設備。若您留下髒亂的環境或造成家具損毀，需額外支付清潔維護費用。\r\n\r\n• 遵守大樓規範，公共區域應保持輕聲細語，請勿大聲喧嘩。\r\n\r\n• 請配合準時離場，不得提早進入或超時使用。\r\n\r\n• 不可烹飪或使用明火之加熱設備。\r\n\r\n• 不可將空間內家具搬離空間。\r\n\r\n• 除等待進入外，不得逗留或佔用公共空間。\r\n\r\n• 不可攜帶寵物入內（導盲犬則不在此限）。\r\n\r\n• 嚴禁吸菸、毒品、性愛、攜帶危險物品，以及賭博等違反法令規定、公共秩序或善良風俗的行為。\r\n\r\n• 由於使用者的故意或過失，導致場地遭受損害時，WeSpace 將向該使用者要求賠償。','使用的 5 天前，提供無條件免費更改訂單的服務，內容包含：「取消退費」、「改期」、「延長縮短時間」、「更改空間」。詳請請聯繫 WeSpace 的官方 Line 帳號 (ID: @wespace)','臺北市','大安區','永吉路30巷158弄21號','「市政府」站4號出口，步行 3 分鐘','「消防局」站，步行 4 分鐘','「Upark」停車場，步行 1 分鐘',20,40,3,0,1,480.0,600.0,'6','23',1,7),(4,'4am Station','• 【直播限定優惠】假日 2500/hr！請在預訂時註明用途為直播，即可使用優惠價。\r\n\r\n• 遵守大樓規範，公共區域應保持輕聲細語，請勿大聲喧嘩。\r\n\r\n• 使用後自行清潔環境，愛惜空間內所有裝潢設備。若您留下髒亂的環境或造成家具損毀，需額外支付清潔維護費用。\r\n\r\n• 請配合準時離場，不得提早進入或超時使用。\r\n\r\n• 不可烹飪或使用明火之加熱設備。\r\n\r\n• 不可將空間內家具搬離空間。\r\n\r\n• 除等待進入外，不得逗留或佔用公共空間。\r\n\r\n• 不可攜帶寵物入內（導盲犬則不在此限）。\r\n\r\n• 嚴禁吸菸、毒品、性愛、攜帶危險物品，以及賭博等違反法令規定、公共秩序或善良風俗的行為。\r\n\r\n• 由於使用者的故意或過失，導致場地遭受損害時，WeSpace 將向該使用者要求賠償。','使用的 5 天前，提供無條件免費更改訂單的服務，內容包含：「取消退費」、「改期」、「延長縮短時間」、「更改空間」。詳請請聯繫 WeSpace 的官方 Line 帳號 (ID: @wespace)','臺北市','南港區','玉成街25巷2號','「松山」站4號出口，步行 5 分鐘','「玉成里」站，步行 2 分鐘','「潤泰停車場」，步行 3 分鐘',75,300,4,0,2,2500.0,2500.0,'8','20',1,7),(5,'小樹屋企業遠距辦公','【企業彈性遠距、異地分流辦公方案】\r\n\r\n因應政府防疫措施，小樹屋除可日租辦公\r\n\r\n同時推出企業遠距、異地分流辦公優惠專案\r\n\r\n# 全台北超過 20 個據點，2 ~ 40 人空間供企業安心選擇。\r\n\r\n# 支援線上信用卡支付或匯款，並可開立統編發票。\r\n\r\n5 日租方案：$4,800 起\r\n\r\n12 日租方案：$10,000 起\r\n\r\n月租方案：更長租期享最高優惠！預訂及更多優惠，請洽小樹屋 LINE 客服 @kzu3062y','','臺北市','大安區','承德路一段35號 9 樓','','','',45,40,5,0,2,450.0,450.0,'8','20',1,5),(6,'寰宇中心100人大教室','‼ 因場地整修，於 2022/1/1 之後始能提供租借 ‼\r\n\r\n• 遵守大樓規範，公共區域應保持輕聲細語，請勿大聲喧嘩。\r\n\r\n• 使用後自行清潔環境，愛惜空間內所有裝潢設備。若您留下髒亂的環境或造成家具損毀，需額外支付清潔維護費用。\r\n\r\n• 請配合準時離場，不得提早進入或超時使用。\r\n\r\n• 不可烹飪或使用明火之加熱設備。\r\n\r\n• 不可將空間內家具搬離空間。\r\n\r\n• 除等待進入外，不得逗留或佔用公共空間。\r\n\r\n• 不可攜帶寵物入內（導盲犬則不在此限）。\r\n\r\n• 嚴禁吸菸、毒品、性愛、攜帶危險物品，以及賭博等違反法令規定、公共秩序或善良風俗的行為。\r\n\r\n• 由於使用者的故意或過失，導致場地遭受損害時，Pickone 將向該使用者要求賠償。','使用的 5 天前，提供無條件免費更改訂單的服務，內容包含：「取消退費」、「改期」、「延長縮短時間」、「更改空間」。詳請請聯繫 WeSpace 的官方 Line 帳號 (ID: @wespace)','臺北市','中山區','建國北路二段3巷15號4樓-2','「松江南京」站6號出口，步行 6 分鐘','「捷運松江南京」站，步行 6 分鐘','「台灣聯通停車場」，步行 1 分鐘',50,100,6,0,1,1500.0,1700.0,'9','18',1,7),(7,'CLAPPER STUDIO','禁止使用明火','如果想取消預約該怎麼辦？','臺北市','中正區','市民大道三段2號','忠孝新生站1號出口','','',165,400,7,0,1,70000.0,90000.0,'8','23',1,7),(8,'Syntrend Show','禁止使用明火','E-Mail來信通知','臺北市','中正區','市民大道三段2號 12 樓','捷運忠孝新生站','','',240,400,7,0,1,70000.0,90000.0,'8','23',1,7),(9,'uMeal Bistro 竹科店','◀不怕吵鬧，具舞台，可歡樂辦活動或表演的優質場地►\r\n\r\n◆每人低消為一杯飲料或一份餐點。\r\n\r\n◆空間容納人數最多50人，舒適人數為34人。\r\n\r\n◆用畢後請將場地空間及桌椅復原，垃圾請分類後請餐廳協助處理，留給下一位使用者乾淨的空間。\r\n\r\n◆若空間使用者留下髒亂的垃圾、環境或造成設備損壞，將視情況收取$1,000~$5,000元不等的費用。\r\n\r\n◆禁止烹飪、點燃明火、攜帶危險物品、吸菸、毒品、性愛，以及賭博等違反法令規定、公共秩序或善良風俗的行為。違者將直接取消使用權利，如有任何法律責任，須由空間使用者自行負責。\r\n\r\n◆由於空間使用者的故意或過失，導致空間遭受損害時，我方將向該使用者要求賠償。\r\n\r\n◆空間使用者於租用開始之前、中、後，任何放置於空間內、公共區域之物品，我方不負責任何保管及賠償責任。\r\n\r\n◆我方保留主動刪除空間使用者預訂之權利。\r\n\r\n','使用的 5 天前，提供無條件免費更改訂單的服務，內容包含：「取消退費」、「改期」、「延長縮短時間」、「更改空間」。詳請請聯繫 WeSpace 的官方 Line 帳號 (ID: @wespace)','新竹市','東區','金山八街46號2樓','','可搭「世博3號公車」至「金山八街」站，步行 1 分鐘','「八街停車場」味恬鐵板燒轉入，步行 3 分鐘',40,50,8,0,1,1500.0,1800.0,'14','22',1,7);
/*!40000 ALTER TABLE `FACILITIES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_IMAGES`
--

DROP TABLE IF EXISTS `FACILITIES_IMAGES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_IMAGES` (
  `FACILITIES_IMAGES_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地圖片ID',
  `FACILITIES_IMAGES_NAME` varchar(200) DEFAULT NULL COMMENT '場地圖片',
  `FACILITIES_ID` int DEFAULT NULL COMMENT '場地照片',
  PRIMARY KEY (`FACILITIES_IMAGES_ID`),
  KEY `FACILITIES_IMAGES_FACILITIES_ID_FK` (`FACILITIES_ID`),
  CONSTRAINT `FACILITIES_IMAGES_FACILITIES_ID_FK` FOREIGN KEY (`FACILITIES_ID`) REFERENCES `FACILITIES` (`FACILITIES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_IMAGES`
--

LOCK TABLES `FACILITIES_IMAGES` WRITE;
/*!40000 ALTER TABLE `FACILITIES_IMAGES` DISABLE KEYS */;
INSERT INTO `FACILITIES_IMAGES` VALUES (13,'1643248473177HOWSHOW6.jpeg',1),(16,'1643249177314HOWSHOW1.jpeg',1),(17,'1643249177315HOWSHOW2.jpeg',1),(18,'1643249177315HOWSHOW3.jpeg',1),(19,'1643249177315HOWSHOW4.jpeg',1),(20,'1643249177315HOWSHOW5.jpeg',1),(21,'1643249177315HOWSHOW6.jpeg',1),(22,'1643249177316HOWSHOW7.jpeg',1),(23,'1643251237878古亭六號01空間1.jpeg',2),(24,'1643251237878古亭六號01空間2.jpeg',2),(25,'1643251237879古亭六號01空間3.jpeg',2),(26,'1643251237879古亭六號01空間4.jpeg',2),(27,'1643251237879古亭六號01空間5.jpeg',2),(28,'1643251237879古亭六號01空間6.jpeg',2),(29,'1643251237879古亭六號01空間7.jpeg',2),(30,'1643251599308NotOnlyCafe1.jpeg',3),(31,'1643251599309NotOnlyCafe2.jpeg',3),(32,'1643251599309NotOnlyCafe3.jpeg',3),(33,'1643251599309NotOnlyCafe4.jpeg',3),(34,'1643251599309NotOnlyCafe5.jpeg',3),(35,'1643251599309NotOnlyCafe6.jpeg',3),(36,'1643251599310NotOnlyCafe7.jpeg',3),(37,'16432545638514AM1.jpeg',4),(38,'16432545638524AM2.jpeg',4),(39,'16432545638524AM3.jpeg',4),(40,'16432545638524AM4.jpeg',4),(41,'16432545638524AM5.jpeg',4),(42,'16432545638524AM6.jpeg',4),(43,'16432545638534AM7.jpeg',4),(44,'1643254786002小樹屋1.jpeg',5),(45,'1643254786003小樹屋2.jpeg',5),(46,'1643254786003小樹屋3.jpeg',5),(47,'1643254786003小樹屋4.jpeg',5),(48,'1643254786003小樹屋5.jpeg',5),(49,'1643254786003小樹屋6.jpeg',5),(50,'1643254786004小樹屋7.jpeg',5),(51,'1643255096239寰宇中心1.jpeg',6),(52,'1643255096239寰宇中心2.jpeg',6),(53,'1643255096239寰宇中心3.jpeg',6),(54,'1643255096239寰宇中心4.jpeg',6),(55,'1643255096240寰宇中心5.jpeg',6),(56,'1643255096240寰宇中心6.jpeg',6),(57,'1643256477052CLAPPERSTUDIO1.jpeg',7),(58,'1643256477053CLAPPERSTUDIO2.jpeg',7),(59,'1643256477053CLAPPERSTUDIO3.jpeg',7),(60,'1643256477053CLAPPERSTUDIO4.jpeg',7),(61,'1643256477053CLAPPERSTUDIO5.jpeg',7),(62,'1643256630439SyntrendShow1.jpeg',8),(63,'1643256630439SyntrendShow2.jpeg',8),(64,'1643256630439SyntrendShow3.jpeg',8),(65,'1643256630440SyntrendShow4.jpeg',8),(66,'1643256630440SyntrendShow5.jpeg',8),(67,'1643256630440SyntrendShow6.jpeg',8),(68,'1643256929575uMealBistro竹科店1.jpeg',9),(69,'1643256929575uMealBistro竹科店2.jpeg',9),(70,'1643256929576uMealBistro竹科店3.jpeg',9),(71,'1643256929576uMealBistro竹科店4.jpeg',9),(72,'1643256929577uMealBistro竹科店5.jpeg',9),(73,'1643256929577uMealBistro竹科店6.jpeg',9),(74,'1643256929577uMealBistro竹科店7.jpeg',9);
/*!40000 ALTER TABLE `FACILITIES_IMAGES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_ITEMS`
--

DROP TABLE IF EXISTS `FACILITIES_ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_ITEMS` (
  `FACILITIES_ITEMS_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地服務與設備ID',
  `FACILITIES_ITEMS_NAME` varchar(50) DEFAULT NULL COMMENT '場地服務與設備',
  `FACILITIES_ITEMS_CATG_ID` int DEFAULT NULL COMMENT '場地設備分類',
  PRIMARY KEY (`FACILITIES_ITEMS_ID`),
  KEY `FACILITIES_ITEMS_FACILITIES_ITEMS_CATG_FK` (`FACILITIES_ITEMS_CATG_ID`),
  CONSTRAINT `FACILITIES_ITEMS_FACILITIES_ITEMS_CATG_FK` FOREIGN KEY (`FACILITIES_ITEMS_CATG_ID`) REFERENCES `FACILITIES_ITEMS_CATG` (`FACILITIES_ITEMS_CATG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_ITEMS`
--

LOCK TABLES `FACILITIES_ITEMS` WRITE;
/*!40000 ALTER TABLE `FACILITIES_ITEMS` DISABLE KEYS */;
INSERT INTO `FACILITIES_ITEMS` VALUES (1,'桌子',1),(2,'折疊桌',1),(3,'椅子',1),(4,'折疊椅',1),(5,'沙發',1),(6,'板凳',1),(7,'冷氣',1),(8,'廁所',1),(9,'無線網路',1),(10,'延長線',1),(11,'飲水機',1),(12,'黑板',2),(13,'粉筆',2),(14,'白板',2),(15,'白板筆',2),(16,'磁鐵',2),(17,'事務機',2),(18,'電腦',2),(19,'投影機',3),(20,'投影幕',3),(21,'轉機頭',3),(22,'投影筆',3),(23,'螢幕/電視',3),(24,'麥克風',3),(25,'音響設備',3),(26,'隔音設備',3),(27,'相機/攝影機',3),(28,'廚房',4),(29,'餐具',4),(30,'鍋具',4),(31,'微波爐',4),(32,'烤箱',4),(33,'冰箱',4),(34,'電磁爐',4),(35,'卡拉OK',5),(36,'電子遊戲機',5),(37,'烤肉用具',5),(38,'桌遊',5),(39,'樂團設備',6),(40,'包廂',6),(41,'休息室',6),(42,'電梯',6),(43,'停車位',6),(44,'戶外空間',6),(45,'攝影棚',6),(46,'無障礙空間',6),(47,'舞台',6),(48,'泳池',6),(49,'大眾運輸系統',7),(50,'停車場',7),(51,'便利商店．超市',7),(52,'餐飲店',7),(53,'飲料提供',8),(54,'餐點提供',8),(55,'外燴服務',8),(56,'可帶外食',8),(57,'現場人員駐點',9),(58,'可吸菸',9),(59,'可烹調',9),(60,'可帶小孩',9),(61,'寵物友善',9),(62,'自由調整擺設',9),(63,'垃圾代收',9),(64,'滅火器',10),(65,'地震包',10),(66,'緩降機',10),(67,'急救箱',10),(68,'灑水器',10),(69,'煙霧偵測器',10),(70,'火災警報器',10);
/*!40000 ALTER TABLE `FACILITIES_ITEMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_ITEMS_CATG`
--

DROP TABLE IF EXISTS `FACILITIES_ITEMS_CATG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_ITEMS_CATG` (
  `FACILITIES_ITEMS_CATG_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地服務與設備分類ID',
  `FACILITIES_ITEMS_CATG_NAME` varchar(50) DEFAULT NULL COMMENT '場地服務與設備分類名稱',
  PRIMARY KEY (`FACILITIES_ITEMS_CATG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_ITEMS_CATG`
--

LOCK TABLES `FACILITIES_ITEMS_CATG` WRITE;
/*!40000 ALTER TABLE `FACILITIES_ITEMS_CATG` DISABLE KEYS */;
INSERT INTO `FACILITIES_ITEMS_CATG` VALUES (1,'基礎設備'),(2,'會議 ‧ 辦公設備'),(3,'影音設備'),(4,'廚房設備'),(5,'娛樂設備'),(6,'附加設施'),(7,'週邊設施'),(8,'餐飲服務'),(9,'服務'),(10,'安全 ‧ 急救設備');
/*!40000 ALTER TABLE `FACILITIES_ITEMS_CATG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_ITEMS_DETAIL`
--

DROP TABLE IF EXISTS `FACILITIES_ITEMS_DETAIL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_ITEMS_DETAIL` (
  `FACILITIES_ID` int NOT NULL COMMENT '場地ID',
  `FACILITIES_ITEMS_ID` int NOT NULL COMMENT '場地服務與設備ID',
  PRIMARY KEY (`FACILITIES_ID`,`FACILITIES_ITEMS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_ITEMS_DETAIL`
--

LOCK TABLES `FACILITIES_ITEMS_DETAIL` WRITE;
/*!40000 ALTER TABLE `FACILITIES_ITEMS_DETAIL` DISABLE KEYS */;
INSERT INTO `FACILITIES_ITEMS_DETAIL` VALUES (1,1),(1,2),(1,3),(1,4),(1,7),(1,8),(1,9),(1,11),(1,19),(1,20),(1,23),(1,24),(1,27),(1,49),(1,50),(1,64),(1,67),(1,68),(1,69),(1,70),(2,1),(2,3),(2,4),(2,5),(2,7),(2,9),(2,12),(2,14),(2,15),(2,49),(2,50),(2,51),(2,52),(3,1),(3,3),(3,7),(3,8),(3,9),(3,12),(3,14),(3,15),(3,19),(3,20),(3,24),(3,25),(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(5,1),(5,3),(5,7),(5,8),(5,9),(5,11),(5,14),(5,15),(5,18),(5,19),(5,20),(5,24),(5,25),(6,1),(6,2),(6,3),(6,4),(6,5),(6,7),(6,8),(6,9),(6,19),(6,20),(6,24),(6,25),(6,49),(6,50),(7,1),(7,3),(7,5),(7,7),(7,8),(7,11),(8,1),(8,3),(8,5),(8,7),(8,8),(8,9),(9,1),(9,2),(9,3),(9,4),(9,7),(9,8),(9,9),(9,28),(9,29),(9,30),(9,31),(9,32),(9,33);
/*!40000 ALTER TABLE `FACILITIES_ITEMS_DETAIL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_OPENING`
--

DROP TABLE IF EXISTS `FACILITIES_OPENING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_OPENING` (
  `FACILITIES_OPENING_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地開放日ID',
  `FACILITIES_OPENING_NAME` varchar(50) DEFAULT NULL COMMENT '場地開放日名稱',
  PRIMARY KEY (`FACILITIES_OPENING_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_OPENING`
--

LOCK TABLES `FACILITIES_OPENING` WRITE;
/*!40000 ALTER TABLE `FACILITIES_OPENING` DISABLE KEYS */;
INSERT INTO `FACILITIES_OPENING` VALUES (1,'週一'),(2,'週二'),(3,'週三'),(4,'週四'),(5,'週五'),(6,'週六'),(7,'週日');
/*!40000 ALTER TABLE `FACILITIES_OPENING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_OPENING_DETAIL`
--

DROP TABLE IF EXISTS `FACILITIES_OPENING_DETAIL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_OPENING_DETAIL` (
  `FACILITIES_OPENING_DETAIL_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地ID',
  `FACILITIES_ID` int NOT NULL COMMENT '場地ID',
  `FACILITIES_OPENING_ID` int NOT NULL COMMENT '場地開放日ID',
  `FACILITIES_OPENING_START` varchar(20) DEFAULT NULL COMMENT '場地開始時間',
  `FACILITIES_OPENING_CLOSE` varchar(20) DEFAULT NULL COMMENT '場地關閉時間',
  `FACILITIES_OPENING_EXPENSE` decimal(8,1) DEFAULT NULL COMMENT '場地時間價格',
  PRIMARY KEY (`FACILITIES_OPENING_DETAIL_ID`),
  KEY `FACILITIES_ID` (`FACILITIES_ID`),
  KEY `FACILITIES_OPENING_ID` (`FACILITIES_OPENING_ID`),
  CONSTRAINT `facilities_opening_detail_ibfk_1` FOREIGN KEY (`FACILITIES_ID`) REFERENCES `FACILITIES` (`FACILITIES_ID`),
  CONSTRAINT `facilities_opening_detail_ibfk_2` FOREIGN KEY (`FACILITIES_OPENING_ID`) REFERENCES `FACILITIES_OPENING` (`FACILITIES_OPENING_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_OPENING_DETAIL`
--

LOCK TABLES `FACILITIES_OPENING_DETAIL` WRITE;
/*!40000 ALTER TABLE `FACILITIES_OPENING_DETAIL` DISABLE KEYS */;
INSERT INTO `FACILITIES_OPENING_DETAIL` VALUES (1,1,1,'7','23',450.0),(2,1,2,'7','23',450.0),(3,1,3,'7','23',450.0),(4,1,4,'7','23',450.0),(5,1,5,'7','23',450.0),(6,1,6,'7','23',450.0),(7,2,2,'8','22',250.0),(8,2,3,'8','22',250.0),(9,2,4,'8','22',250.0),(10,2,5,'8','22',250.0),(11,2,6,'8','22',250.0),(12,2,7,'8','22',250.0),(13,3,1,'6','23',480.0),(14,3,2,'6','23',480.0),(15,3,3,'6','23',480.0),(16,3,4,'6','23',480.0),(17,3,5,'6','23',480.0),(18,3,6,'6','23',600.0),(19,3,7,'6','23',600.0),(20,4,1,'8','20',2500.0),(21,4,3,'8','20',2500.0),(22,4,4,'8','20',2500.0),(23,4,6,'8','20',2500.0),(24,4,7,'8','20',2500.0),(25,6,1,'9','18',1500.0),(26,6,2,'9','18',1500.0),(27,6,3,'9','18',1500.0),(28,6,4,'9','18',1500.0),(29,6,5,'9','18',1500.0),(30,6,6,'9','18',1700.0),(31,6,7,'9','18',1700.0),(32,5,1,'8','20',450.0),(33,5,2,'8','20',450.0),(34,5,3,'8','20',450.0),(35,5,4,'8','20',450.0),(36,5,5,'8','20',450.0),(37,7,1,'8','23',70000.0),(38,7,2,'8','23',70000.0),(39,7,3,'8','23',70000.0),(40,7,6,'8','23',90000.0),(41,7,7,'8','23',90000.0),(42,8,1,'8','23',70000.0),(43,8,3,'8','23',70000.0),(44,8,5,'8','23',70000.0),(45,8,6,'9','23',90000.0),(46,8,7,'9','23',90000.0),(47,9,1,'14','22',1500.0),(48,9,2,'14','22',1500.0),(49,9,3,'14','22',1500.0),(50,9,5,'14','22',1500.0),(51,9,6,'14','22',1800.0),(52,9,7,'14','22',1800.0);
/*!40000 ALTER TABLE `FACILITIES_OPENING_DETAIL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_OWNER`
--

DROP TABLE IF EXISTS `FACILITIES_OWNER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_OWNER` (
  `FACILITIES_OWNER_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地管理者ID',
  `FACILITIES_OWNER_NAME` varchar(50) DEFAULT NULL COMMENT '管理者名稱',
  `FACILITIES_OWNER_IMAGE` varchar(200) DEFAULT NULL COMMENT '管理者照片',
  `FACILITIES_OWNER_DESCRIPTION` text COMMENT '管理者資訊',
  `FACILITIES_OWNER_CONTACT_NAME` varchar(20) DEFAULT NULL COMMENT '窗口稱呼',
  `FACILITIES_OWNER_CONTACT_PHONE` varchar(20) DEFAULT NULL COMMENT '窗口電話',
  `FACILITIES_OWNER_CONTACT_MOBILE_PHONE` varchar(20) DEFAULT NULL COMMENT '窗口手機',
  `FACILITIES_OWNER_INVOICE_HEADING` varchar(200) DEFAULT NULL COMMENT '管理者發票抬頭',
  `FACILITIES_OWNER_TAX_ID` varchar(8) DEFAULT NULL COMMENT '管理者發票統編',
  `FACILITIES_OWNER_PAYEE_NAME` varchar(50) DEFAULT NULL COMMENT '匯款戶名',
  `FACILITIES_OWNER_PAYEE_BANK_NAME` varchar(50) DEFAULT NULL COMMENT '匯款銀行名稱',
  `FACILITIES_OWNER_PAYEE_BRANCH_NAME` varchar(50) DEFAULT NULL COMMENT '匯款分行名稱',
  `FACILITIES_OWNER_ACCOUNT` varchar(50) DEFAULT NULL COMMENT '匯款帳號',
  `MEMBER_ID` int DEFAULT NULL COMMENT '會員id',
  PRIMARY KEY (`FACILITIES_OWNER_ID`),
  KEY `FACILITIES_OWNER_MEMBER_ID_FK` (`MEMBER_ID`),
  CONSTRAINT `FACILITIES_OWNER_MEMBER_ID_FK` FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER` (`MEMBER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_OWNER`
--

LOCK TABLES `FACILITIES_OWNER` WRITE;
/*!40000 ALTER TABLE `FACILITIES_OWNER` DISABLE KEYS */;
INSERT INTO `FACILITIES_OWNER` VALUES (1,'HOWSHOW','1643248070015HOWSHOW1.jpeg','HOWSHOW台北中山空間站','陳小亘','0912293836','0912293836','HOWSHOW租賃有限公司','42031884','陳小亘','005','三重分行','12903747419264',2),(2,'MRT文創古亭6號空間','1643251230736古亭六號01空間1.jpeg','MRT文創古亭6號空間','陳小亘','0912293836','0912293836','MRT文創租賃公司','19217371','陳小亘','004','三重分行','19478124981246',2),(3,'Not Only Cafe','1643251595916NotOnlyCafe1.jpeg','Not Only Cafe咖啡店','吳孟育','0223895507','0975123973','一家人實業社','42495291','吳孟育','008','三重分行','8134926491264',1),(4,'4am Station','16432545596914AM1.jpeg','4am Station','陳小亘','0291824124','0985127312','四點鐘有限公司','19247128','陳小亘','050','三重分行','128479814696',2),(5,'小樹屋 Treerful','1643254781489小樹屋1.jpeg','小樹屋 Treerful','陳小亘','0293183813','0912713646','小樹屋實業社','42495291','陳小亘','004','三重分行','1243117496164',2),(6,'寰宇中心','1643255090444寰宇中心1.jpeg','寰宇中心','吳孟育','0229318173','0975123973','寰宇股份有限公司','19214713','吳孟育','004','三重分行','12094731473319',1),(7,'台北市政府','1643256472010CLAPPERSTUDIO1.jpeg','台北市政府','陳小亘','0293837133','0981624614','','','陳小亘','012','三重分行','12948172461864',1),(8,'癒善糧餐飲有限公司','1643256922842uMealBistro竹科店1.jpeg','癒善糧餐飲有限公司','吳孟育','0921384812','0975123973','癒善糧餐飲有限公司','12481748','癒善糧餐飲有限公司','006','新竹分行','93582963916519',1);
/*!40000 ALTER TABLE `FACILITIES_OWNER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_REVIEW`
--

DROP TABLE IF EXISTS `FACILITIES_REVIEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_REVIEW` (
  `FACILITIES_REVIEW_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地評論ID',
  `FACILITIES_REVIEW_TIME` timestamp NULL DEFAULT NULL COMMENT '評論時間',
  `FACILITIES_REVIEW_STARS` int DEFAULT NULL COMMENT '評論星數',
  `FACILITIES_REVIEW_DESCRIPTION` text COMMENT '評論內容',
  `MEMBER_ID` int DEFAULT NULL COMMENT '評論會員',
  `FACILITIES_ID` int DEFAULT NULL COMMENT '評論場地',
  PRIMARY KEY (`FACILITIES_REVIEW_ID`),
  KEY `FACILITIES_REVIEW_MEMBER_ID_FK` (`MEMBER_ID`),
  KEY `FACILITIES_REVIEW_FACILITIES_ID_FK` (`FACILITIES_ID`),
  CONSTRAINT `FACILITIES_REVIEW_FACILITIES_ID_FK` FOREIGN KEY (`FACILITIES_ID`) REFERENCES `FACILITIES` (`FACILITIES_ID`),
  CONSTRAINT `FACILITIES_REVIEW_MEMBER_ID_FK` FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER` (`MEMBER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_REVIEW`
--

LOCK TABLES `FACILITIES_REVIEW` WRITE;
/*!40000 ALTER TABLE `FACILITIES_REVIEW` DISABLE KEYS */;
/*!40000 ALTER TABLE `FACILITIES_REVIEW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_TYPE`
--

DROP TABLE IF EXISTS `FACILITIES_TYPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_TYPE` (
  `FACILITIES_TYPE_ID` int NOT NULL AUTO_INCREMENT COMMENT '場地類型ID',
  `FACILITIES_TYPE_NAME` varchar(50) DEFAULT NULL COMMENT '場地類型名稱',
  PRIMARY KEY (`FACILITIES_TYPE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_TYPE`
--

LOCK TABLES `FACILITIES_TYPE` WRITE;
/*!40000 ALTER TABLE `FACILITIES_TYPE` DISABLE KEYS */;
INSERT INTO `FACILITIES_TYPE` VALUES (1,'會議'),(2,'派對'),(3,'聚會'),(4,'私人談話'),(5,'課程講座'),(6,'運動'),(7,'工作'),(8,'展覽'),(9,'音樂/表演'),(10,'婚禮'),(11,'拍照/攝影'),(12,'美容'),(13,'烹飪'),(14,'儲物'),(15,'發表會'),(16,'親子活動'),(17,'其他');
/*!40000 ALTER TABLE `FACILITIES_TYPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FACILITIES_TYPE_DETAIL`
--

DROP TABLE IF EXISTS `FACILITIES_TYPE_DETAIL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FACILITIES_TYPE_DETAIL` (
  `FACILITIES_ID` int NOT NULL COMMENT '場地ID',
  `FACILITIES_TYPE_ID` int NOT NULL COMMENT '場地類型ID',
  PRIMARY KEY (`FACILITIES_ID`,`FACILITIES_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FACILITIES_TYPE_DETAIL`
--

LOCK TABLES `FACILITIES_TYPE_DETAIL` WRITE;
/*!40000 ALTER TABLE `FACILITIES_TYPE_DETAIL` DISABLE KEYS */;
INSERT INTO `FACILITIES_TYPE_DETAIL` VALUES (1,1),(1,2),(1,3),(1,4),(1,7),(1,8),(1,11),(2,1),(2,2),(2,3),(2,4),(2,5),(2,7),(2,11),(2,15),(2,17),(3,2),(3,3),(3,4),(3,5),(3,7),(3,8),(3,11),(3,12),(4,2),(4,3),(4,5),(4,8),(4,9),(4,10),(4,11),(5,1),(5,5),(5,7),(5,17),(6,1),(6,3),(6,5),(6,7),(6,8),(6,11),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9),(7,10),(7,11),(7,12),(7,15),(7,16),(7,17),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10),(8,11),(8,12),(8,15),(8,16),(8,17),(9,1),(9,2),(9,3),(9,5),(9,6),(9,7),(9,8),(9,9),(9,10),(9,11),(9,16);
/*!40000 ALTER TABLE `FACILITIES_TYPE_DETAIL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MANAGER`
--

DROP TABLE IF EXISTS `MANAGER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MANAGER` (
  `MANAGER_ID` int NOT NULL AUTO_INCREMENT COMMENT '管理員ID',
  `MANAGER_ACCOUNT` varchar(50) DEFAULT NULL COMMENT '管理員帳號',
  `MANAGER_PASSWORD` varchar(50) DEFAULT NULL COMMENT '管理員密碼',
  `MANAGER_EMAIL` varchar(50) DEFAULT NULL COMMENT '管理員信箱',
  `MANAGER_LOG` varchar(200) DEFAULT NULL COMMENT '管理員日誌檔案',
  `MANAGER_STATEMENT` varchar(200) DEFAULT NULL COMMENT '報表檔案',
  PRIMARY KEY (`MANAGER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MANAGER`
--

LOCK TABLES `MANAGER` WRITE;
/*!40000 ALTER TABLE `MANAGER` DISABLE KEYS */;
/*!40000 ALTER TABLE `MANAGER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MEMBER`
--

DROP TABLE IF EXISTS `MEMBER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MEMBER` (
  `MEMBER_ID` int NOT NULL AUTO_INCREMENT COMMENT '會員ID',
  `MEMBER_ACCOUNT` varchar(50) DEFAULT NULL COMMENT '會員帳號',
  `MEMBER_PASSWORD` varchar(50) DEFAULT NULL COMMENT '會員密碼',
  `MEMBER_EMAIL` varchar(50) DEFAULT NULL COMMENT '會員信箱',
  `MEMBER_FIRSTNAME` varchar(20) DEFAULT NULL COMMENT '會員姓氏',
  `MEMBER_LASTNAME` varchar(20) DEFAULT NULL COMMENT '會員名字',
  `MEMBER_MOBILE_PHONE` varchar(20) DEFAULT NULL COMMENT '會員手機號碼',
  `MEMBER_CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '會員建立時間',
  `MEMBER_VALIDATE_CODE` varchar(255) DEFAULT NULL COMMENT '認證激活碼',
  `MEMBER_TOKEN` varchar(255) DEFAULT NULL COMMENT 'uuid',
  `MEMBER_STATUS` int DEFAULT NULL COMMENT '會員狀態',
  PRIMARY KEY (`MEMBER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MEMBER`
--

LOCK TABLES `MEMBER` WRITE;
/*!40000 ALTER TABLE `MEMBER` DISABLE KEYS */;
INSERT INTO `MEMBER` VALUES (1,'hank0521macos@gmail.com','2CA9A1B1176A430B534610A74650B84D','hank0521macos@gmail.com','吳','孟育','0975123973','2022-01-27 01:38:20',NULL,NULL,1),(2,'md6666dv@gmail.com','2CA9A1B1176A430B534610A74650B84D','md6666dv@gmail.com','陳','小亘','0912293836','2022-01-27 01:39:12',NULL,NULL,1),(3,'a18077081a@gmail.com','2CA9A1B1176A430B534610A74650B84D','a18077081a@gmail.com','蔡','小豪','0981736283','2022-01-27 04:39:07',NULL,NULL,1);
/*!40000 ALTER TABLE `MEMBER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDERS`
--

DROP TABLE IF EXISTS `ORDERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDERS` (
  `ORDERS_ID` int NOT NULL AUTO_INCREMENT COMMENT '訂單ID',
  `ORDERS_SPACE_NAME` varchar(200) DEFAULT NULL COMMENT '空間名字',
  `ORDERS_DATE` datetime DEFAULT NULL COMMENT '活動日期',
  `ORDERS_PERIOD_START` int DEFAULT NULL COMMENT '活動開始時段',
  `ORDERS_PERIOD_END` int DEFAULT NULL COMMENT '活動結束時段',
  `ORDERS_EXPENSE` decimal(8,1) DEFAULT NULL COMMENT '訂單費用',
  `ORDERS_GUESTS` int DEFAULT NULL COMMENT '使用人數',
  `ORDERS_NOTE` text COMMENT '訂單備註',
  `ORDERS_CONTACT_NAME` varchar(50) DEFAULT NULL COMMENT '聯絡人姓名',
  `ORDERS_CONTACT_MOBILE_PHONE` varchar(20) DEFAULT NULL COMMENT '聯絡人手機',
  `ORDERS_CONTACT_EMAIL` varchar(50) DEFAULT NULL COMMENT '聯絡人信箱',
  `ORDERS_CREDIT_CARD_NO` varchar(50) DEFAULT NULL COMMENT '信用卡卡號',
  `ORDERS_CREDIT_CARD_MONTH` varchar(10) DEFAULT NULL COMMENT '信用卡到期月',
  `ORDERS_CREDIT_CARD_YEAR` varchar(10) DEFAULT NULL COMMENT '信用卡到期年',
  `ORDERS_CREDIT_CARD_CVC` varchar(3) DEFAULT NULL COMMENT '信用卡驗證碼',
  `ORDERS_TIME` timestamp NULL DEFAULT NULL COMMENT '訂單生成時間',
  `ORDERS_STATUS` int DEFAULT NULL COMMENT '訂單狀態',
  `ORDERS_STATUS_NOTE` text COMMENT '訂單狀態描述',
  `MEMBER_ID` int DEFAULT NULL COMMENT '訂購人',
  `FACILITIES_ID` int DEFAULT NULL COMMENT '租借場地',
  `FACILITIES_TYPE_ID` int DEFAULT NULL COMMENT '場地使用目的',
  PRIMARY KEY (`ORDERS_ID`),
  KEY `ORDERS_MEMBER_ID_FK` (`MEMBER_ID`),
  KEY `ORDERS_FACILITIES_ID_FK` (`FACILITIES_ID`),
  KEY `ORDERS_FACILITIES_TYPE_ID_FK` (`FACILITIES_TYPE_ID`),
  CONSTRAINT `ORDERS_FACILITIES_ID_FK` FOREIGN KEY (`FACILITIES_ID`) REFERENCES `FACILITIES` (`FACILITIES_ID`),
  CONSTRAINT `ORDERS_FACILITIES_TYPE_ID_FK` FOREIGN KEY (`FACILITIES_TYPE_ID`) REFERENCES `FACILITIES_TYPE` (`FACILITIES_TYPE_ID`),
  CONSTRAINT `ORDERS_MEMBER_ID_FK` FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER` (`MEMBER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDERS`
--

LOCK TABLES `ORDERS` WRITE;
/*!40000 ALTER TABLE `ORDERS` DISABLE KEYS */;
INSERT INTO `ORDERS` VALUES (1,'HOWSHOW | 中山國小(台北) ','2022-01-29 14:00:00',10,19,4050.0,6,'可以自備食物嗎？','吳孟育','0975123973','hank0521macos@gmail.com','2030,1203,2220,2019','01','26','148','2022-01-27 04:38:06',2,NULL,1,1,1),(2,'古亭六號01空間','2022-02-09 14:00:00',18,21,750.0,4,'','蔡小豪','0981736283','a18077081a@gmail.com','3991,2837,1836,2827','01','29','201','2022-01-27 04:41:05',0,NULL,3,2,7),(3,'HOWSHOW | 中山國小(台北) ','2022-01-29 14:00:00',7,12,2250.0,5,'','蔡小豪','0981736283','a18077081a@gmail.com','3991,9339,2221,2331','03','23','111','2022-01-27 04:41:40',3,'很抱歉，當日因有特殊原因，故暫停營業！',3,1,2),(4,'HOWSHOW | 中山國小(台北) ','2022-02-09 14:00:00',7,11,1800.0,4,'','蔡小豪','0981736283','a18077081a@gmail.com','1993,2837,2731,2736','01','26','333','2022-01-27 04:42:11',4,NULL,3,1,1),(5,'HOWSHOW | 中山國小(台北) ','2022-02-16 14:00:00',12,20,3600.0,3,'','蔡小豪','0981736283','a18077081a@gmail.com','3913,2837,2635,2631','01','29','392','2022-01-27 04:42:59',5,NULL,3,1,17),(6,'古亭六號01空間','2022-01-28 14:00:00',8,14,1500.0,5,'','吳孟育','0975123973','hank0521macos@gmail.com','3918,2837,2736,2163','05','27','123','2022-01-27 04:44:47',1,NULL,1,2,3),(7,'CLAPPER STUDIO','2022-02-21 14:00:00',18,21,210000.0,200,'','陳小亘','0912293836','md6666dv@gmail.com','3193,2837,1826,2613','11','23','123','2022-01-27 05:01:56',4,NULL,2,7,9),(8,'寰宇中心100人大教室','2022-01-29 14:00:00',9,14,8500.0,10,'','陳小亘','0912293836','md6666dv@gmail.com','3184,2736,3713,2731','02','23','192','2022-01-27 05:02:33',3,'很抱歉，您提供的資料不正確，恕無法為您保留訂位！',2,6,3),(9,'小樹屋企業遠距辦公','2022-02-08 14:00:00',8,13,2250.0,10,'','陳小亘','0912293836','md6666dv@gmail.com','2183,2736,2712,2712','01','23','123','2022-01-27 05:03:05',3,'很抱歉，當日訂位已額滿，恕無法提供您當日訂位！',2,5,1),(10,'小樹屋企業遠距辦公','2022-02-09 14:00:00',10,15,2250.0,10,'','陳小亘','0912293836','md6666dv@gmail.com','2183,2736,2712,2712','01','23','123','2022-01-27 05:04:05',2,NULL,2,5,1),(11,'小樹屋企業遠距辦公','2022-02-10 14:00:00',10,15,2250.0,10,'','陳小亘','0912293836','md6666dv@gmail.com','2183,2736,2712,2712','01','23','123','2022-01-27 05:05:05',4,NULL,2,5,2),(12,'小樹屋企業遠距辦公','2022-02-09 14:00:00',10,15,2250.0,10,'','陳小亘','0912293836','md6666dv@gmail.com','2183,2736,2712,2712','01','23','123','2022-01-27 05:06:05',1,NULL,2,5,2),(14,'古亭六號01空間','2022-02-22 14:00:00',8,14,1500.0,5,'','吳孟育','0975123973','hank0521macos@gmail.com','3918,2837,2736,2163','05','27','123','2022-01-27 07:44:47',1,NULL,1,2,3),(15,'古亭六號01空間','2022-01-30 14:00:00',8,14,1500.0,5,'','吳孟育','0975123973','hank0521macos@gmail.com','3918,2837,2736,2163','05','27','123','2022-01-27 04:45:47',0,NULL,1,2,3),(18,'Not Only Cafe','2022-02-08 14:00:00',7,15,3840.0,1,'','陳小亘','0912293836','md6666dv@gmail.com','2938,2831,2831,1923','01','23','123','2022-01-27 05:17:36',2,NULL,2,3,13),(19,'Not Only Cafe','2022-02-22 14:00:00',9,15,2880.0,2,'','陳小亘','0912293836','md6666dv@gmail.com','3187,2736,2615,2731','12','23','123','2022-01-27 05:18:21',4,NULL,2,3,5),(20,'寰宇中心100人大教室','2022-02-07 14:00:00',9,14,7500.0,4,'','陳小亘','0912293836','md6666dv@gmail.com','3991,2838,2881,2912','12','21','102','2022-01-27 05:22:06',5,NULL,2,6,7),(21,'寰宇中心100人大教室','2022-02-14 14:00:00',9,12,4500.0,5,'','陳小亘','0912293836','md6666dv@gmail.com','3189,2819,2813,2731','02','26','123','2022-01-27 05:22:43',2,NULL,2,6,7),(22,'Not Only Cafe','2022-02-22 14:00:00',6,12,2880.0,5,'','陳小亘','0912293836','md6666dv@gmail.com','3813,2163,2736,1273','12','26','123','2022-01-27 05:23:52',3,'很抱歉，您備註上的需求，恕無法提供！',2,3,5),(24,'uMeal Bistro 竹科店','2022-02-15 14:00:00',14,20,9000.0,10,'','蔡小豪','0981736283','a18077081a@gmail.com','3183,2731,2812,2731','03','23','123','2022-01-27 05:25:27',1,NULL,3,9,3),(25,'uMeal Bistro 竹科店','2022-02-15 14:00:00',14,18,6000.0,16,'','蔡小豪','0981736283','a18077081a@gmail.com','1389,2731,2618,2731','10','23','123','2022-01-27 05:27:40',1,NULL,3,9,5),(26,'Syntrend Show','2022-02-20 14:00:00',10,15,450000.0,50,'','陳小亘','0912293836','md6666dv@gmail.com','1437,2174,2891,2916','02','23','123','2022-01-27 05:31:33',1,NULL,2,8,15),(27,'4am Station','2022-02-09 14:00:00',8,12,10000.0,100,'','蔡小豪','0981736283','a18077081a@gmail.com','1298,2894,2451,2467','12','24','123','2022-01-27 05:34:01',1,NULL,3,4,9);
/*!40000 ALTER TABLE `ORDERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wespace'
--
/*!50003 DROP PROCEDURE IF EXISTS `mainSearch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mainSearch`(
	IN spaceType INT,
    IN spaceCity VARCHAR(255),
    IN spaceGuestsMin INT,
    IN spaceGuestsMax INT
)
IF(spaceType is null) THEN
BEGIN
	SELECT * 
	FROM facilities F
	WHERE F.facilities_city = if(spaceCity is null,F.facilities_city,spaceCity) AND
		  F.facilities_guests >= if(spaceGuestsMin is null,F.facilities_guests,spaceGuestsMin) AND 
		  F.facilities_guests <= if(spaceGuestsMax is null,F.facilities_guests,spaceGuestsMax);
END;

ELSE
BEGIN
	SELECT * 
	FROM facilities F
	INNER JOIN facilities_type_detail T
    ON F.facilities_id = T.facilities_id
	WHERE T.facilities_type_id = if(spaceType is null,T.facilities_type_id,spaceType) AND 
		  F.facilities_city = if(spaceCity is null,F.facilities_city,spaceCity) AND
		  F.facilities_guests >= if(spaceGuestsMin is null,F.facilities_guests,spaceGuestsMin) AND 
		  F.facilities_guests <= if(spaceGuestsMax is null,F.facilities_guests,spaceGuestsMax);
END;
END IF ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `subSearch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `subSearch`(
	IN spaceType INT,
    IN spaceGuestsMin INT,
    IN spaceGuestsMax INT,
	IN spaceCity VARCHAR(255),
	IN spaceMaxBudget INT,
    IN spaceMinBudget INT,
    IN spaceName VARCHAR(255),
    IN spaceMinOpeningDay INT,
    IN spaceMaxOpeningDay INT,
    IN spacePeriod INT
)
BEGIN
IF(spaceType is null) THEN
	SELECT * 
	FROM facilities F
	WHERE F.facilities_guests >= if(spaceGuestsMin is null,F.facilities_guests,spaceGuestsMin) AND 
		  F.facilities_guests <= if(spaceGuestsMax is null,F.facilities_guests,spaceGuestsMax) AND
          F.facilities_city = if(spaceCity is null,F.facilities_city,spaceCity) AND
          F.facilities_max_budget <= if(spaceMaxBudget is null,F.facilities_max_budget,spaceMaxBudget) AND
          F.facilities_min_budget >= if(spaceMinBudget is null,F.facilities_min_budget,spaceMinBudget) AND
		  F.facilities_name like if(spaceName = '%%' ,'%',spaceName) AND
          (((F.facilities_min_opening_day >= if(spaceMinOpeningDay is null,F.facilities_min_opening_day,spaceMinOpeningDay) AND F.facilities_min_opening_day <= if(spaceMaxOpeningDay is null,F.facilities_min_opening_day,spaceMaxOpeningDay))) OR
		  ((F.facilities_max_opening_day >= if(spaceMinOpeningDay is null,F.facilities_max_opening_day,spaceMinOpeningDay) AND F.facilities_max_opening_day <= if(spaceMaxOpeningDay is null,F.facilities_max_opening_day,spaceMaxOpeningDay)))) AND
		  (floor(F.facilities_start_time/6) = if(spacePeriod is null,floor(F.facilities_start_time/6),spacePeriod) or floor(F.facilities_close_time/6) = if(spacePeriod is null,floor(F.facilities_close_time/6),spacePeriod) or
          if(((F.facilities_close_time - F.facilities_start_time)/6)>=2,floor((F.facilities_close_time-6)/6),floor(F.facilities_close_time/6)) = if(spacePeriod is null,floor((F.facilities_close_time-6)/6),spacePeriod) or
          if(((F.facilities_close_time - F.facilities_start_time)/6)>=2,floor((F.facilities_close_time-12)/6),floor(F.facilities_close_time/6)) = if(spacePeriod is null,floor((F.facilities_close_time-12)/6),spacePeriod));
		
ELSE IF(spaceType is not null) THEN
	SELECT * 
	FROM facilities F
	INNER JOIN facilities_type_detail T
    ON F.facilities_id = T.facilities_id
	WHERE T.facilities_type_id = if(spaceType is null,T.facilities_type_id,spaceType) AND
		  F.facilities_guests >= if(spaceGuestsMin is null,F.facilities_guests,spaceGuestsMin) AND 
		  F.facilities_guests <= if(spaceGuestsMax is null,F.facilities_guests,spaceGuestsMax) AND
          F.facilities_city = if(spaceCity is null,F.facilities_city,spaceCity) AND
          F.facilities_max_budget <= if(spaceMaxBudget is null,F.facilities_max_budget,spaceMaxBudget) AND
          F.facilities_min_budget >= if(spaceMinBudget is null,F.facilities_min_budget,spaceMinBudget) AND
		  F.facilities_name like if(spaceName = '%%' ,'%',spaceName) AND
          (((F.facilities_min_opening_day >= if(spaceMinOpeningDay is null,F.facilities_min_opening_day,spaceMinOpeningDay) AND F.facilities_min_opening_day <= if(spaceMaxOpeningDay is null,F.facilities_min_opening_day,spaceMaxOpeningDay))) OR
		  ((F.facilities_max_opening_day >= if(spaceMinOpeningDay is null,F.facilities_max_opening_day,spaceMinOpeningDay) AND F.facilities_max_opening_day <= if(spaceMaxOpeningDay is null,F.facilities_max_opening_day,spaceMaxOpeningDay)))) AND
		  (floor(F.facilities_start_time/6) = if(spacePeriod is null,floor(F.facilities_start_time/6),spacePeriod) or floor(F.facilities_close_time/6) = if(spacePeriod is null,floor(F.facilities_close_time/6),spacePeriod) or
		  if(((F.facilities_close_time - F.facilities_start_time)/6)>=2,floor((F.facilities_close_time-6)/6),floor(F.facilities_close_time/6)) = if(spacePeriod is null,floor((F.facilities_close_time-6)/6),spacePeriod) or
          if(((F.facilities_close_time - F.facilities_start_time)/6)>=2,floor((F.facilities_close_time-12)/6),floor(F.facilities_close_time/6)) = if(spacePeriod is null,floor((F.facilities_close_time-12)/6),spacePeriod));
END IF;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-07  9:17:19

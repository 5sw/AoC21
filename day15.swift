@main
struct Day15: Puzzle {
    mutating func run() {
        let part1 = find(target: Point(x: width - 1, y: height - 1))
        print("Part 1:", part1)

        let part2 = find(target: Point(x: 5 * width - 1, y: 5 * height - 1))
        print("Part 2:", part2)
    }

    struct Point: Hashable {
        var x: Int
        var y: Int

        var neighbors: [Point] {
            [
                Point(x: x - 1, y: y),
                Point(x: x + 1, y: y),
                Point(x: x, y: y - 1),
                Point(x: x, y: y + 1)
            ]
        }
    }

    func find(target: Point) -> Int {
        var current = Point(x: 0, y: 0)
        var totalCost = 0

        var possible: [Point: Int] = [:]
        var visited: Set<Point> = []

        func isInside(_ point: Point) -> Bool {
            0...target.x ~= point.x && 0...target.y ~= point.y
        }

        while current != target {
            visited.insert(current)

            for n in current.neighbors where isInside(n) && !visited.contains(n) {
                possible[n] = min(possible[n, default: .max], totalCost + self[n])
            }

            (current, totalCost) = possible.min { $0.value < $1.value }!

            possible.removeValue(forKey: current)
        }

        return totalCost
    }

    subscript(point: Point) -> Int {
        self[point.x , point.y]
    }

    subscript(x: Int, y: Int) -> Int {
        let repX = x / width
        let xPos = x % width

        let repY = y / height
        let yPos = y % height

        return (input[xPos + width * yPos] + repX + repY - 1) % 9 + 1
    }

    let width = 100
    let height = 100

    let input: [Int] = """
8576219475874583191916312133474175459337114195988185136398151631965391991813219974121211251194786128
1713881999231519357799114192443351147195293575386923868711388519361669464234397975938889146414199688
2151922113728581598379349983928489926261239862882888968998791929828316718921297117449631496888879522
3291722311299652548445221254456535112944431135116631433192483199481594768169444158222431199929579291
1472287315918113113959972189351931626141472991992791413146153989481318998519171231313898962992319251
8978798318873934543151823824117132228417869392811216547172919119998739911121199246294815175868992773
4711149989992717728465321161611967173674239298593935117599173279267114155265393397571372124856718732
9843245319692998612781837729915931371619886371128818266322121623171343132131239399743799827972585645
7183211712173272827112268971459424836293613294388761928991542137194981939169315879277494581991465822
2385721996578834579224651431411717198341139751429156637229888849181154922897746418293184413519931124
6188313732929496115412842928273812153715747411177189187726751991191841181119822534511125656211991265
8797112815141319881991983914861912838966446818811271274141461487947171138945321912192198815813211761
6131514331472951494911549373681638637191295997625615885219668259269297171939941498581919718223529141
3916711951831246219991217199412116783411218814949692281987659123812288937983969116847986196936523779
9111121227192813382983442234171148191131821497435387936912532695293912972491131977272231919798477344
9994893855122115213919995636978443773161196511775674783979472217917498285423121574533491643891265199
9245818921321877317663254739619499915821162412924816263648913499811482474392667993739139899758919393
1717618849193152316325119128859116191132672215933282127611134982961918179152189411131259943819997123
3697848795188715264992962617223177221118919863975198881197837936258983111819488622362584888223331999
1798259211962116675922944295117391732295963342131192112612386194749389991199821195162975124619149837
5365696872959269494682128272373619348283964191994187749824841195582221478325111187843285531119934786
6717218734155417511564162235845524121493736962442884479191718924594119911521121422231982184671122116
9346412964321187889663345611132183519588187791111227269112129947122999176114184938494824342939375892
2912811929919891428891223818529115949522464779949526791515797886471246181118183121786524127979998512
7353285281129811915971956929718433284441492484117162562212973157265812816731843791838571691421923924
3239161911151141369392413114665193927469988999219478935992541193184945926828911597158489999651151172
9229716159183212219791136121569512978927999177196111291668152292896495877722611129462617229299962112
5994461796358342348216915883991574569784887978731368749888449599246152414391635925763156831839199496
1569319989929452917219726368583887924179117119284971126181346919789949393972171262535283921926293357
9983673949614595396426594299567925779229751982433631919159114841538978735893759492592481573495963491
3725632421623191323789991288299296415942162988289929992238877153268488127718372211951117951486111926
1219319492614741819142363452974731825929485665978219725131218962626179997611254524524915768686381164
8248145978417221154822663831966124539168641311913211295941167919583189792718599334616827916567313217
3483959252172951953519211189255336234459522397526829492685113849198611624111948187714151963198671919
7812289559812455122297839958719917624841136314322613942214613249662544617928521344873779598816941946
6868958791119815122313931178313637489923479492171741443993619161318781194421239654468391996636923611
6999166111129212624151555925991311538952878946191234511973499736237742491811348911419449161895978178
3532973784281182181552481928144111246711742443831184236962981395142863562121961323169398316921741321
8433727191521455193223914171391447439164791659118411391327413285243717794299999523811137619197999791
8169125649963232439519311131691539694589231314268683691811431259295132344195953951287639889737849189
8928161919934761971442719391119881113318323987227229831917897151155121657624142152884624176461913498
2949199492196424164751892146395174669111921799261527568751283712133148212821261936297739912939743599
9931616797885267969938591912672996183187926259991298429278229232257219428413174972999193796827459799
3138768154311742899419449741617489465993174645228814938145273266941566223933119891379181296548999222
1338961668848636157444719898575174699419997972125194827176897565699991611654214368232592793825617931
9283643143692917314535119897889711191946688911436965194232811624712861576291987716317193114445363435
8718611398299869991788113111214414269554542114329621286592313532782819131919527228417764279755899812
8128249329314753847725634378737239939769913811444529224619715471961999278915341955188871714271145449
1286217894699991715153139268991918988338684391252271254127193342854156438873836258484975151167996316
4191439845728418348368191516746499654147257851256861534634988281199187541199892317145428248531129171
9799283477747387253566811199414256363339122372629545249542373591951156699415998714124115397811359516
3191985767689943186838293175311429527499612824265518522881922917119891424717751985621941995373481629
8127933395192162886259956635985821651844893796541627799276258692298972881471991789861232424926758792
4349683335349673317521761437148933192989961489478395417258212949865876242843242464123471244631449998
3983861771861891251448475182984833811718959521263444111998834975935221115813839514917176912994677265
3361812177831144971531441184671112122322312961859915722393944269211333951428175372918136112814926411
2492891241191991149319731182431211211971267682931551534199328118919751416881458658314218331565282229
1316191719349114251772629411233483317516143684488291792691839198723174287211241498955137331159443961
1295632882814319179937625629218199381191127966181781921829819969815912382191294796979515315471941392
1952318366571121641614137937116326339638859628226299126699118638171813164397332391891669798271559135
1123676641998146639499323488991286491444174358479157916696196841912233773269986812299996975117612192
2496461124219121332118311532239527696198787778122345883331631119147159212262659717289674149798169111
3994915157217763242581922474512992479146377117411981999549977495462427199524334285127723311599337186
2856249932899117429471617195415229923432185189218399415357391954728651191591964713418532917111296399
1916415314958527255299763241981929186681257596912948977397875248189748655173819381269954513499896991
4214987991254389723346911149661118597277889213928551947599177915888233175182921923128853579525754718
3582279578128192231339943295188563998645998149526284997789731787116991199391984141983177825883111821
3318115949152512995142691231324793411691198458654473675135993122216324137859959272731599996923465431
9431374329994955614816239978928993493129129641248882311462522524447519388869238199852941551532223632
6749132793518479891929891686579791123712167784913331559922969149125915827657111724348929978159964476
6899888192198113996189996152913216258469182711411338723293823541574149295918323829819122941288693461
9833728958423343229397292861582211971713299293611778961979819175799893793971822162383179128129741328
9719459171294372288418126215914532995125999274359633129923191213332337513812761149562146497198614329
6323381739518574154814713691189651618965915153972197836392492518147816118266818195856772641337997448
9515391698994467556612815425651153225477392335219196697477512338938131933398177519117437353271396315
2881769116189531115832167881372917543267529333184621316918481786111252281738298936313393416198972192
1262821848371618529985323295192217356152412696271318793198457225899782896767339942896611231999996177
7611115824284211421951282951346181221891123993118231772195952872865982323819415318945742389969468591
6289176957971112617212793915412958239574931721216722823933461763146195116737161463663388274118352919
2739192179312181318764617662499189345995579913463399176128133623751919135855775349195561978131664671
7419179135228196296753972713643556671138381494838116814212892453118963456121883515171981991493112197
2351962484381996196119791327953881225881124837211622273581789216339733276411173141146816794919111532
4828494193941149581788515219884312818182198261739598611663311138255885557141492174934279519487959315
6266441934234532987821537914696156313934795144412166199339199381197916324959558778257894958593689511
1218836684761811498991162549547375891999161535133511817388897491266957819219117988952234747197245136
7714718988198712181711441996373181351671962319416917816121119483959397254815953421521642116185224622
6315878819598412161782318179586237893968466116199183185764132999388411414821117761121199725212571499
9298381112525419214597534611761811137687414291394795245955115116482261788724982532573616634235949295
2513837618149681781571514782119218925111312739891194994857915371836413112952729282168681511999132471
9859244419394114469927618849921646911349163815889492121537711577378978633345419421881312649299234749
6241913851991287776811271361777919519213726771122769111499925516752149976397933753482495291399144132
7549785323789821947513966787125532113931855716249321712383292746672763573114656989299712174939322181
9188852123922512181114117536955617335173328988385462159798591117758397298294919117614163738414981949
2974419341361292817129453536824618155299993142149899966226312193848695911943416589913541194129913422
1672761999113289962322634642122163368424955339864962951462929691975798622972131599198673671183449929
3462285147627397867977869242451116812198183328383813959284449969199819896174618466572298882951459875
6153638634925613615423256118159531429294172496996993184762972841759153392753653191942715379879852345
6516291128536155113712481272992636373774429965994966353494115221979925592128929821611928492143929534
3993993153713717844719492314391992638719111242291783837279215399219822611221331985991484863975594721
5995891457939115884519762228128552168915218299831775259316392719113962218429351553267511523198149462
""".compactMap { $0.wholeNumberValue }

}

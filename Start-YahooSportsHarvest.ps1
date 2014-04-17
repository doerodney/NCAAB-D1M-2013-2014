[CmdletBinding()]
param(
    [int] $Year = 0,

    [int] $Month = 0,

    [int] $Day = 0
)
    Set-StrictMode -Version Latest


    # Typical daily URL is like this:
    # http://sports.yahoo.com/college-basketball/scoreboard/?date=2013-12-23&conf=8

    $ConferenceHash = @{
     'America East' = 99
     'Atlantic Coast' = 6
     'Atlantic Ten' = 101
     'Atlantic Sun' = 107
     'American Athletic' = 201
     'Big 12' = 103
     'Big East' = 102
     'Big Sky' = 15
     'Big South' = 16
     'Big Ten' = 3
     'Big West' = 8
     'Colonial Athletic' = 17
     'Conference USA' = 1
     'Horizon League' = 34
     'Independents' = 35
     'Ivy League' = 18
     'Metro Atlantic Athletic' = 19
     'Mid-American' = 20
     'Mid-Eastern' = 31
     'Missouri Valley' = 21
     'Mountain West' = 112
     'Northeast' = 32
     'Ohio Valley' = 23
     'Pac-12' =  2
     'Patriot League' = 24
     'Southeastern' = 10
     'Southland' = 28
     'Southwestern Athletic' = 105
     'Summit' = 194
     'Sun Belt' = 5
     'West Coast' = 110
     'Western Athletic' = 111
    }


    $TeamConferenceHash =
    @{
        'abilene-christian-wildcats' = 'Southland'
        'air-force-falcons' = 'Mountain West'
        'akron-zips' = 'Mid-American'
        'alabama-am-bulldogs' = 'Southwestern Athletic'
        'alabama-crimson-tide' = 'Southeastern'
        'alabama-state-hornets' = 'Southwestern Athletic'
        'albany-great-danes' = 'America East'
        'alcorn-state-braves' = 'Southwestern Athletic'
        'american-university-eagles' = 'Patriot League'
        'appalachian-state-mountaineers' = 'Southern'
        'arizona-state-sun-devils' = 'Pac-12'
        'arizona-wildcats' = 'Pac-12'
        'arkansas-razorbacks' = 'Southeastern'
        'arkansas-state-red-wolves' = 'Sun Belt'
        'army-black-knights' = 'Patriot League'
        'auburn-tigers' = 'Southeastern'
        'austin-peay-governors' = 'Ohio Valley'
        'ball-state-cardinals' = 'Mid-American'
        'baylor-bears' = 'Big 12'
        'belmont-bruins' = 'Ohio Valley'
        'bethune-cookman-wildcats' = 'Mid-Eastern'
        'binghamton-bearcats' = 'America East'
        'boise-state-broncos' = 'Mountain West'
        'boston-college-eagles' = 'Atlantic Coast'
        'boston-university-terriers' = 'Patriot League'
        'bowling-green-falcons' = 'Mid-American'
        'bradley-braves' = 'Missouri Valley'
        'brown-bears' = 'Ivy League'
        'bryant-bulldogs' = 'Northeast'
        'bucknell-bison' = 'Patriot League'
        'buffalo-bulls' = 'Mid-American'
        'butler-bulldogs' = 'Big East'
        'byu-cougars' = 'West Coast'
        'cal-poly-mustangs' = 'Big West'
        'cal-state-fullerton-titans' = 'Big West'
        'cal-state-northridge-matadors' = 'Big West'
        'california-golden-bears' = 'Pac-12'
        'campbell-fighting-camels' = 'Big South'
        'canisius-golden-griffins' = 'Metro Atlantic Athletic'
        'central-arkansas-bears' = 'Southland'
        'central-connecticut-state-blue-devils' = 'Northeast'
        'central-michigan-chippewas' = 'Mid-American'
        'charleston-cougars' = 'Colonial Athletic'
        'charleston-southern-buccaneers' = 'Big South'
        'charlotte-49ers' = 'Conference USA'
        'chattanooga-mocs' = 'Southern'
        'chicago-state-cougars' = 'Western Athletic'
        'cincinnati-bearcats' = 'American Athletic'
        'citadel-bulldogs' = 'Southern'
        'clemson-tigers' = 'Atlantic Coast'
        'cleveland-state-vikings' = 'Horizon League'
        'coastal-carolina-chanticleers' = 'Big South'
        'colgate-raiders' = 'Patriot League'
        'colorado-buffaloes' = 'Pac-12'
        'colorado-state-rams' = 'Mountain West'
        'columbia-lions' = 'Ivy League'
        'connecticut-huskies' = 'American Athletic'
        'coppin-state-eagles' = 'Mid-Eastern'
        'cornell-big-red' = 'Ivy League'
        'creighton-bluejays' = 'Big East'
        'csu-bakersfield-roadrunners' = 'Western Athletic'
        'dartmouth-big-green' = 'Ivy League'
        'davidson-wildcats' = 'Southern'
        'dayton-flyers' = 'Atlantic Ten'
        'delaware-fightin-blue-hens' = 'Colonial Athletic'
        'delaware-state-hornets' = 'Mid-Eastern'
        'denver-pioneers' = 'Summit'
        'depaul-blue-demons' = 'Big East'
        'detroit-titans' = 'Horizon League'
        'drake-bulldogs' = 'Missouri Valley'
        'drexel-dragons' = 'Colonial Athletic'
        'duke-blue-devils' = 'Atlantic Coast'
        'duquesne-dukes' = 'Atlantic Ten'
        'east-carolina-pirates' = 'Conference USA'
        'east-tennessee-state' = 'Atlantic Sun'
        'eastern-illinois-panthers' = 'Ohio Valley'
        'eastern-kentucky-colonels' = 'Ohio Valley'
        'eastern-michigan-eagles' = 'Mid-American'
        'eastern-washington-eagles' = 'Big Sky'
        'elon-phoenix' = 'Southern'
        'evansville-aces' = 'Missouri Valley'
        'fairfield-stags' = 'Metro Atlantic Athletic'
        'fairleigh-dickinson-knights' = 'Northeast'
        'fgcu-eagles' = 'Atlantic Sun'
        'fiu-golden-panthers' = 'Conference USA'
        'florida-am-rattlers' = 'Mid-Eastern'
        'florida-atlantic-owls' = 'Conference USA'
        'florida-gators' = 'Southeastern'
        'florida-state-seminoles' = 'Atlantic Coast'
        'fordham-rams' = 'Atlantic Ten'
        'fresno-state-bulldogs' = 'Mountain West'
        'furman-paladins' = 'Southern'
        'gardner-webb-runnin-bulldogs' = 'Big South'
        'george-mason-patriots' = 'Atlantic Ten'
        'george-washington-colonials' = 'Atlantic Ten'
        'georgetown-hoyas' = 'Big East'
        'georgia-bulldogs' = 'Southeastern'
        'georgia-southern-eagles' = 'Southern'
        'georgia-state-panthers' = 'Sun Belt'
        'georgia-tech-yellow-jackets' = 'Atlantic Coast'
        'gonzaga-bulldogs' = 'West Coast'
        'grambling-state-tigers' = 'Southwestern Athletic'
        'grand-canyon-antelopes' = 'Western Athletic'
        'green-bay-phoenix' = 'Horizon League'
        'hampton-pirates' = 'Mid-Eastern'
        'hartford-hawks' = 'America East'
        'harvard-crimson' = 'Ivy League'
        'hawaii-rainbow-warriors' = 'Big West'
        'high-point-panthers' = 'Big South'
        'hofstra-pride' = 'Colonial Athletic'
        'holy-cross-crusaders' = 'Patriot League'
        'houston-baptist-huskies' = 'Southland'
        'houston-cougars' = 'American Athletic'
        'howard-bison' = 'Mid-Eastern'
        'idaho-state-bengals' = 'Big Sky'
        'idaho-vandals' = 'Western Athletic'
        'illinois-fighting-illini' = 'Big Ten'
        'illinois-state-redbirds' = 'Missouri Valley'
        'incarnate-word-cardinals' = 'Southland'
        'indiana-hoosiers' = 'Big Ten'
        'indiana-state-sycamores' = 'Missouri Valley'
        'iona-gaels' = 'Metro Atlantic Athletic'
        'iowa-hawkeyes' = 'Big Ten'
        'iowa-state-cyclones' = 'Big 12'
        'ipfw-mastodons' = 'Summit'
        'iupui-jaguars' = 'Summit'
        'jackson-state-tigers' = 'Southwestern Athletic'
        'jacksonville-dolphins' = 'Atlantic Sun'
        'jacksonville-state-gamecocks' = 'Ohio Valley'
        'james-madison-dukes' = 'Colonial Athletic'
        'kansas-jayhawks' = 'Big 12'
        'kansas-state-wildcats' = 'Big 12'
        'kennesaw-state-owls' = 'Atlantic Sun'
        'kent-state-golden-flashes' = 'Mid-American'
        'kentucky-wildcats' = 'Southeastern'
        'la-salle-explorers' = 'Atlantic Ten'
        'lafayette-leopards' = 'Patriot League'
        'lamar-cardinals' = 'Southland'
        'lehigh-mountain-hawks' = 'Patriot League'
        'liberty-flames' = 'Big South'
        'lipscomb-bisons' = 'Atlantic Sun'
        'liu-brooklyn-blackbirds' = 'Northeast'
        'long-beach-state-49ers' = 'Big West'
        'longwood-lancers' = 'Big South'
        'louisiana-monroe-warhawks' = 'Sun Belt'
        'louisiana-ragin-cajuns' = 'Sun Belt'
        'louisiana-tech-bulldogs' = 'Conference USA'
        'louisville-cardinals' = 'American Athletic'
        'loyola-chicago-ramblers' = 'Missouri Valley'
        'loyola-maryland-greyhounds' = 'Patriot League'
        'loyola-marymount-lions' = 'West Coast'
        'lsu-tigers' = 'Southeastern'
        'maine-black-bears' = 'America East'
        'manhattan-jaspers' = 'Metro Atlantic Athletic'
        'marist-red-foxes' = 'Metro Atlantic Athletic'
        'marquette-golden-eagles' = 'Big East'
        'marshall-thundering-herd' = 'Conference USA'
        'maryland-eastern-shore-hawks' = 'Mid-Eastern'
        'maryland-terrapins' = 'Atlantic Coast'
        'massachusetts-lowell-river-hawks' = 'America East'
        'massachusetts-minutemen' = 'Atlantic Ten'
        'mcneese-state-cowboys' = 'Southland'
        'memphis-tigers' = 'American Athletic'
        'mercer-bears' = 'Atlantic Sun'
        'miami-fl-hurricanes' = 'Atlantic Coast'
        'miami-oh-redhawks' = 'Mid-American'
        'michigan-state-spartans' = 'Big Ten'
        'michigan-wolverines' = 'Big Ten'
        'middle-tennessee-blue-raiders' = 'Conference USA'
        'milwaukee-panthers' = 'Horizon League'
        'minnesota-golden-gophers' = 'Big Ten'
        'mississippi-state-bulldogs' = 'Southeastern'
        'mississippi-valley-state-delta-devils' = 'Southwestern Athletic'
        'missouri-state-bears' = 'Missouri Valley'
        'missouri-tigers' = 'Southeastern'
        'monmouth-hawks' = 'Metro Atlantic Athletic'
        'montana-grizzlies' = 'Big Sky'
        'montana-state-bobcats' = 'Big Sky'
        'morehead-state-eagles' = 'Ohio Valley'
        'morgan-state-bears' = 'Mid-Eastern'
        'mount-st-marys-mountaineers' = 'Northeast'
        'murray-state-racers' = 'Ohio Valley'
        'navy-midshipmen' = 'Patriot League'
        'nebraska-cornhuskers' = 'Big Ten'
        'nebraska-omaha-mavericks' = 'Summit'
        'nevada-wolf-pack' = 'Mountain West'
        'new-hampshire-wildcats' = 'America East'
        'new-mexico-lobos' = 'Mountain West'
        'new-mexico-state-aggies' = 'Western Athletic'
        'new-orleans-privateers' = 'Southland'
        'niagara-purple-eagles' = 'Metro Atlantic Athletic'
        'nicholls-colonels' = 'Southland'
        'njit-highlanders' = 'Independents'
        'norfolk-state-spartans' = 'Mid-Eastern'
        'north-carolina-at-aggies' = 'Mid-Eastern'
        'north-carolina-central-eagles' = 'Mid-Eastern'
        'north-carolina-state-wolfpack' = 'Atlantic Coast'
        'north-carolina-tar-heels' = 'Atlantic Coast'
        'north-dakota' = 'Big Sky'
        'north-dakota-state-bison' = 'Summit'
        'north-florida-ospreys' = 'Atlantic Sun'
        'north-texas-mean-green' = 'Conference USA'
        'northeastern-huskies' = 'Colonial Athletic'
        'northern-arizona-lumberjacks' = 'Big Sky'
        'northern-colorado-bears' = 'Big Sky'
        'northern-illinois-huskies' = 'Mid-American'
        'northern-kentucky-norse' = 'Atlantic Sun'
        'northwestern-state-demons' = 'Southland'
        'northwestern-wildcats' = 'Big Ten'
        'notre-dame-fighting-irish' = 'Atlantic Coast'
        'oakland-golden-grizzlies' = 'Horizon League'
        'ohio-bobcats' = 'Mid-American'
        'ohio-state-buckeyes' = 'Big Ten'
        'oklahoma-sooners' = 'Big 12'
        'oklahoma-state-cowboys' = 'Big 12'
        'old-dominion-monarchs' = 'Conference USAConference USA'
        'ole-miss-rebels' = 'Southeastern'
        'oral-roberts-golden-eagles' = 'Southland'
        'oregon-ducks' = 'Pac-12'
        'oregon-state-beavers' = 'Pac-12'
        'pacific-tigers' = 'West Coast'
        'penn-quakers' = 'Ivy League'
        'penn-state-nittany-lions' = 'Big Ten'
        'pepperdine-waves' = 'West Coast'
        'pittsburgh-panthers' = 'Atlantic Coast'
        'portland-pilots' = 'West Coast'
        'portland-state-vikings' = 'Big Sky'
        'prairie-view-am-panthers' = 'Southwestern Athletic'
        'presbyterian-blue-hose' = 'Big South'
        'princeton-tigers' = 'Ivy League'
        'providence-friars' = 'Big East'
        'purdue-boilermakers' = 'Big Ten'
        'quinnipiac-bobcats' = 'Metro Atlantic Athletic'
        'radford-highlanders' = 'Big South'
        'rhode-island-rams' = 'Atlantic Ten'
        'rice-owls' = 'Conference USA'
        'richmond-spiders' = 'Atlantic Ten'
        'rider-broncs' = 'Metro Atlantic Athletic'
        'robert-morris-colonials' = 'Northeast'
        'rutgers-scarlet-knights' = 'American Athletic'
        'sacramento-state-hornets' = 'Big Sky'
        'sacred-heart-pioneers' = 'Northeast'
        'saint-francis-u-red-flash' = 'Northeast'
        'saint-josephs-hawks' = 'Atlantic Ten'
        'saint-louis-billikens' = 'Atlantic Ten'
        'saint-marys-gaels' = 'West Coast'
        'saint-peters-peacocks' = 'Metro Atlantic Athletic'
        'sam-houston-state-bearkats' = 'Southland'
        'samford-bulldogs' = 'Southern'
        'san-diego-state-aztecs' = 'Mountain West'
        'san-diego-toreros' = 'West Coast'
        'san-francisco-dons' = 'West Coast'
        'san-jose-state-spartans' = 'Mountain West'
        'santa-clara-broncos' = 'West Coast'
        'savannah-state-tigers' = 'Mid-Eastern'
        'seattle-redhawks' = 'Western Athletic'
        'seton-hall-pirates' = 'Big East'
        'siena-heights-saints' = 'Metro Atlantic Athletic'
        'siena-saints' = 'Metro Atlantic Athletic'  # purposeful duplicate
        'siue-cougars' = 'Ohio Valley'
        'smu-mustangs' = 'American Athletic'
        'south-alabama-jaguars' = 'Sun Belt'
        'south-carolina-gamecocks' = 'Southeastern'
        'south-carolina-state-bulldogs' = 'Mid-Eastern'
        'south-dakota-coyotes' = 'Summit'
        'south-dakota-state-jackrabbits' = 'Summit'
        'south-florida-bulls' = 'American Athletic'
        'southeast-missouri-state-redhawks' = 'Ohio Valley'
        'southeastern-louisiana-lions' = 'Southland'
        'southern-illinois-salukis' = 'Missouri Valley'
        'southern-miss-golden-eagles' = 'Conference USA'
        'southern-university-jaguars' = 'Southwestern Athletic'
        'southern-utah-thunderbirds' = 'Big Sky'
        'st-bonaventure-bonnies' = 'Atlantic Ten'
        'st-francis-brooklyn-terriers' = 'Northeast'
        'st-johns-red-storm' = 'Big East'
        'stanford-cardinal' = 'Pac-12'
        'stephen-f-austin-lumberjacks' = 'Southland'
        'stetson-hatters' = 'Atlantic Sun'
        'stony-brook-seawolves' = 'America East'
        'syracuse-orange' = 'Atlantic Coast'
        'tcu-horned-frogs' = 'Big 12'
        'temple-owls' = 'American Athletic'
        'tennessee-state-tigers' = 'Ohio Valley'
        'tennessee-tech-golden-eagles' = 'Ohio Valley'
        'tennessee-volunteers' = 'Southeastern'
        'texas-am-aggies' = 'Southeastern'
        'texas-am-corpus-christi-islanders' = 'Southland'
        'texas-longhorns' = 'Big 12'
        'texas-pan-american-broncs' = 'Western Athletic'
        'texas-southern-tigers' = 'Southwestern Athletic'
        'texas-state-bobcats' = 'Sun Belt'
        'texas-tech-red-raiders' = 'Big 12'
        'toledo-rockets' = 'Mid-American'
        'towson-tigers' = 'Colonial Athletic'
        'troy-trojans' = 'Sun Belt'
        'tulane-green-wave' = 'Conference USA'
        'tulsa-golden-hurricane' = 'Conference USA'
        'uab-blazers' = 'Conference USA'
        'ualr-trojans' = 'Sun Belt'
        'uapb-golden-lions' = 'Southwestern Athletic'
        'uc-davis-aggies' = 'Big West'
        'uc-irvine-anteaters' = 'Big West'
        'uc-riverside-highlanders' = 'Big West'
        'uc-santa-barbara-gauchos' = 'Big West'
        'ucf-knights' = 'American Athletic'
        'ucla-bruins' = 'Pac-12'
        'uic-flames' = 'Horizon League'
        'umbc-retrievers' = 'America East'
        'umkc-kangaroos' = 'Western Athletic'
        'unc-asheville-bulldogs' = 'Big South'
        'uncw-seahawks' = 'Colonial Athletic'
        'uni-panthers' = 'Missouri Valley'
        'unlv-runnin-rebels' = 'Mountain West'
        'usc-trojans' = 'Pac-12'
        'usc-upstate-spartans' = 'Atlantic Sun'
        'ut-arlington-mavericks' = 'Sun Belt'
        'ut-martin-skyhawks' = 'Ohio Valley'
        'utah-runnin-utes' = 'Pac-12'
        'utah-state-aggies' = 'Mountain West'
        'utah-valley-wolverines' = 'Western Athletic'
        'utep-miners' = 'Conference USA'
        'utsa-roadrunners' = 'Conference USA'
        'valparaiso-crusaders' = 'Horizon League'
        'vanderbilt-commodores' = 'Southeastern'
        'vcu-rams' = 'Atlantic Ten'
        'vermont-catamounts' = 'America East'
        'villanova-wildcats' = 'Big East'
        'virginia-cavaliers' = 'Atlantic Coast'
        'virginia-tech-hokies' = 'Atlantic Coast'
        'vmi-keydets' = 'Big South'
        'wagner-seahawks' = 'Northeast'
        'wake-forest-demon-deacons' = 'Atlantic Coast'
        'washington-huskies' = 'Pac-12'
        'washington-state-cougars' = 'Pac-12'
        'weber-state-wildcats' = 'Big Sky'
        'west-virginia-mountaineers' = 'Big 12'
        'western-carolina-catamounts' = 'Southern'
        'western-illinois-leathernecks' = 'Summit'
        'western-kentucky-hilltoppers' = 'Sun Belt'
        'western-michigan-broncos' = 'Mid-American'
        'wichita-state-shockers' = 'Missouri Valley'
        'william-and-mary-tribe' = 'Colonial Athletic'
        'winthrop-eagles' = 'Big South'
        'wisconsin-badgers' = 'Big Ten'
        'wofford-terriers' = 'Southern'
        'wright-state-raiders' = 'Horizon League'
        'wyoming-cowboys' = 'Mountain West'
        'xavier-musketeers' = 'Big East'
        'yale-bulldogs' = 'Ivy League'
        'youngstown-state-penguins' = 'Horizon League'
    }

    [string] $nameGameKey = 'gameKey'
    [string] $nameCollege = 'college'
    [string] $nameAthlete = 'athlete'
    [string] $nameMinutes = 'minutes'
    [string] $nameFieldGoalsMade = 'fieldGoalsMade'
    [string] $nameFieldGoalsAttempted = 'fieldGoalsAttempted'
    [string] $nameThreePointersMade = 'threePointersMade'
    [string] $nameThreePointersAttempted = 'threePointersAttempted'
    [string] $nameFreeThrowsMade = 'freeThrowsMade'
    [string] $nameFreeThrowsAttempted = 'freeThrowsAttempted'
    [string] $nameOffensiveRebounds = 'offensiveRebounds'
    [string] $nameDefensiveRebounds = 'defensiveRebounds'
    [string] $nameTotalRebounds = 'totalRebounds'
    [string] $nameAssists = 'assists'
    [string] $nameTurnovers = 'turnovers'
    [string] $nameSteals = 'steals'
    [string] $nameBlockedShots = 'blockedShots'
    [string] $namePersonalFouls = 'personalFouls'
    [string] $namePointsScored = 'pointsScored'

    # Go to top level page and look for these:
    # <tr class="game  link" data-url="/ncaab/high-point-panthers-syracuse-orange-201312200553/" data-index="7" data-gid="ncaab.g.201312200553">
    # A typical URL for a game box score looks like this:
    # http://sports.yahoo.com/ncaab/high-point-panthers-syracuse-orange-201312200553/

function Find-ContentSection
{
    [CmdletBinding()]
    param(
        [string] $Content,

        [string] $TargetStart,

        [string] $TargetEnd
    )


    [int] $idxSearch = 0
    [int] $idxFound = -1
    [int] $idxStart = 0

    [PsObject[]] $contentSectionList = @()

    do {
        $idxFound = $Content.IndexOf($TargetStart, $idxSearch)
        if ($idxFound -ge 0) {
            $itemStartIndex = $idxFound
            $idxSearch = $idxFound + $TargetStart.Length

            $idxFound = $Content.IndexOf($TargetEnd, $idxSearch)
            if ($idxFound -ge 0) {
                $idxSearch = $idxFound + $TargetEnd.Length
            }

            $contentSection = New-Object -TypeName PSObject -Property @{
                startIndex = $itemStartIndex
                length = $idxSearch - $itemStartIndex
            }

            $contentSectionList += $contentSection
        }

    } while ($idxFound -ge 0)

    $contentSectionList
}


function Get-BoxScoreContent
{
    [CmdletBinding()]
    param(
        [string] $Url
    )

    [string] $gameKey = $Url -replace 'http://sports.yahoo.com//ncaab/', ''
    $gameKey = $gameKey -replace '/$', ''

    $wc = New-Object -TypeName System.Net.WebClient
    [string] $content = $wc.DownloadString($Url)

    # A box score starts and ends with these.
    [string] $targetStart = '<h4 '
    [string] $targetEnd = '</table>'

    [PsObject[]] $contentSectionList = Find-ContentSection -Content $content -TargetStart $targetStart -TargetEnd $targetEnd

    [PsObject[]] $athleteRecordList = @()


    $contentSectionList | ForEach-Object {
        $startIndex = $_.startIndex
        $length = $_.length
        [string] $boxScoreContent = $content.Substring($startIndex, $length)
        $boxScoreContent = $boxScoreContent -replace '<colgroup>.+</colgroup>', ''

        # Separate the content into two sections.  Treat the section section as XML.
        [int] $boxScoreContentLength = $boxScoreContent.Length
        [string] $tableStart = '<table'
        [int] $idxTableStart = $boxScoreContent.IndexOf($tableStart, 0)
        [string] $header = $boxScoreContent.Substring(0, $idxTableStart)
        [string] $tableText = $boxScoreContent.Substring($idxTableStart, $boxScoreContentLength - $idxTableStart)
        [xml] $tableXml = [xml] $tableText


        # Parse the school name out of the header.
        $header -match '^<h4.+>(.+)</h4><.+>$' | Out-Null
        [string] $college = $Matches[1]

        # Parse the box score stats out of the table xml.
        $tableXml.table.tbody.tr | ForEach-Object {
            $tr = $_
            # Record data for individual athletes, not summaries.
            if (($tr.th.id -notmatch 'totals') -and ($tr.th.id -notmatch 'percentages')) {
                [string] $athlete = $tr.th.a.'#text'
                [int] $minutes = 0
                [string] $fieldGoals = ''
                [int] $fieldGoalsAttempted = 0
                [int] $fieldGoalsMade = 0
                [string] $threePointers = ''
                [int] $threePointersAttempted = 0
                [int] $threePointersMade = 0
                [string] $freeThrows = ''
                [int] $freeThrowsAttempted = 0
                [int] $freeThrowsMade = 0
                [int] $offensiveRebounds = 0
                [int] $defensiveRebounds = 0
                [int] $totalRebounds = 0
                [int] $assists = 0
                [int] $turnovers = 0
                [int] $steals = 0
                [int] $blockedShots = 0
                [int] $personalFouls = 0
                [int] $pointsScored = 0

                $tr.td | ForEach-Object {
                    $td = $_
                    [string] $title = $td.title
                    switch($title) {
                        'Minutes Played'     { $minutes = $td.'#text' }
                        'Field Goals'        { $fieldGoals = $td.'#text' }
                        'Three Pointers'     { $threePointers = $td.'#text' }
                        'Free Throws'        { $freeThrows = $td.'#text' }
                        'Offensive Rebounds' { $offensiveRebounds = $td.'#text' }
                        'Defensive Rebounds' { $defensiveRebounds = $td.'#text' }
                        'Total Rebounds'     { $totalRebounds = $td.'#text' }
                        'Assists'            { $assists = $td.'#text' }
                        'Turnovers'          { $turnovers = $td.'#text' }
                        'Steals'             { $steals = $td.'#text' }
                        'Blocked Shots'      { $blockedShots = $td.'#text' }
                        'Personal Fouls'     { $personalFouls = $td.'#text' }
                        'Points Scored'      { $pointsScored = $td.'#text' }
                    }
                }

                # Resolve field goals.
                if ($fieldGoals -match '(\d+)-(\d+)') {
                    $fieldGoalsMade = $Matches[1]
                    $fieldGoalsAttempted = $Matches[2]
                }

                # Resolve three pointers.
                if ($threePointers -match '(\d+)-(\d+)') {
                    $threePointersMade = $Matches[1]
                    $threePointersAttempted = $Matches[2]
                }

                # Resolve free throws.
                if ($freeThrows -match '(\d+)-(\d+)') {
                    $freeThrowsMade = $Matches[1]
                    $freeThrowsAttempted = $Matches[2]
                }

                [PsObject] $athleteRecord = New-Object -TypeName PsObject -Property @{
                    $nameGameKey = $gameKey
                    $nameCollege = $college
                    $nameAthlete = $athlete
                    $nameMinutes = $minutes
                    $nameFieldGoalsMade = $fieldGoalsMade
                    $nameFieldGoalsAttempted = $fieldGoalsAttempted
                    $nameThreePointersMade = $threePointersMade
                    $nameThreePointersAttempted = $threePointersAttempted
                    $nameFreeThrowsMade = $freeThrowsMade
                    $nameFreeThrowsAttempted = $freeThrowsAttempted
                    $nameOffensiveRebounds = $offensiveRebounds
                    $nameDefensiveRebounds = $defensiveRebounds
                    $nameTotalRebounds = $totalRebounds
                    $nameAssists = $assists
                    $nameTurnovers = $turnovers
                    $nameSteals = $steals
                    $nameBlockedShots = $blockedShots
                    $namePersonalFouls = $personalFouls
                    $namePointsScored = $pointsScored
                }

                $athleteRecordList += $athleteRecord
            }
        }
    }


    $athleteRecordList
}


function Get-CsvHeader
{
    [string] $header = "`"$nameGameKey`",`"$nameCollege`",`"$nameMinutes`",`"$nameAthlete`",`"$nameFieldGoalsMade`","
    $header += "`"$nameFieldGoalsAttempted`",`"$nameThreePointersMade`",`"$nameThreePointersAttempted`","
    $header += "`"$nameFreeThrowsMade`",`"$nameFreeThrowsAttempted`",`"$nameOffensiveRebounds`",`"$nameDefensiveRebounds`","
    $header += "`"$nameTotalRebounds`",`"$nameAssists`",`"$nameTurnovers`",`"$nameSteals`",`"$nameBlockedShots`",`"$namePersonalFouls`",`"$namePointsScored`""

    $header
}


function Get-CsvRow
{
    param(
        [PsObject] $AthleteRecord
    )

    [string] $row = "`"$($AthleteRecord.$nameGameKey)`",`"$($AthleteRecord.$nameCollege)`",$($AthleteRecord.$nameMinutes),`"$($AthleteRecord.$nameAthlete)`",$($AthleteRecord.$nameFieldGoalsMade),"
    $row += "$($AthleteRecord.$nameFieldGoalsAttempted),$($AthleteRecord.$nameThreePointersMade),$($AthleteRecord.$nameThreePointersAttempted),"
    $row += "$($AthleteRecord.$nameFreeThrowsMade),$($AthleteRecord.$nameFreeThrowsAttempted),$($AthleteRecord.$nameOffensiveRebounds), $($AthleteRecord.$nameDefensiveRebounds),"
    $row += "$($AthleteRecord.$nameTotalRebounds),$($AthleteRecord.$nameAssists),$($AthleteRecord.$nameTurnovers),$($AthleteRecord.$nameSteals),$($AthleteRecord.$nameBlockedShots),$($AthleteRecord.$namePersonalFouls),$($AthleteRecord.$namePointsScored)"

    $row
}


function Get-TeamList
{
    [CmdletBinding()]

    param(
        [string] $gameUrl
    )

    [PsObject[]] $teamList = @()

    # A typical game URL looks like this:
    # http://sports.yahoo.com/ncaab/high-point-panthers-syracuse-orange-201312200553/
    [string] $nameTeam = 'Team'
    [string] $nameConference = 'Conference'
    [string] $nameHome = 'Home'

    Write-Verbose $gameUrl

    [string[]] $keys = $TeamConferenceHash.Keys

    [string] $teams = $gameUrl -replace 'http://sports.yahoo.com/ncaab/', ''
    $teams = $teams -replace '-\d+/', ''

    # These teams cannot be accurately identified with two tokens.
    [string[]] $teamExceptionList = (
        'north-dakota-state-bison',
        'north-dakota',
        'texas-am-aggies',
        'texas-am-corpus-christi-islanders',
        'north-carolina-at-aggies',
        'north-carolina-central-eagles',
        'north-carolina-state-wolfpack',
        'north-carolina-tar-heels',
        'new-mexico-lobos',
        'new-mexico-state-aggies'
    )
    [int] $nTeamExceptions = $teamExceptionList.Count


    [string] $candidate = ''

    # Determine a candidate for the visitor team.
    # The uncovers the oddballs.
    [int] $iException = 0
    for ($iException = 0; $iException -lt $nTeamExceptions; $iException++ ) {
        [string] $teamException = $teamExceptionList[$iException]
        if ($teams -match "^$teamException") {
            $candidate = $teamException
            break
        }
    }

    # This uncovers the routine cases.
    [string[]] $teamTokens = $teams -split '-'
    [int] $nTokens = $teamTokens.Count
    [int] $iToken = 0

    if ($candidate.Length -eq 0) {
        $candidate = $teamTokens[0]

        for( $iToken = 1; $iToken -lt $nTokens; $iToken++) {
            $candidate = $candidate + '-' + $teamTokens[$iToken]
            if ($keys -contains $candidate) {
                break
            }
        }
    }

    # If we found a match, $iToken will be less than $nTokens.
    if ($iToken -lt $nTokens) {
        [string] $conference = $TeamConferenceHash[$candidate]
        [PsObject] $visitorTeam = New-Object -TypeName PsObject -Property @{
            $nameTeam = $candidate
            $nameConference = $conference
            $nameHome = $false
        }

        Write-Verbose "Visitor team:  $visitorTeam"
        $teamList += $visitorTeam

        # The other team's conference key should be the remainder of the tokens.
        $candidate = $teams -replace $candidate, ''
        $candidate = $candidate -replace '^-', ''

        # The home team could be a non-D1 school.
        # Use only if there is a match.
        if ($keys -contains $candidate) {
            $conference = $TeamConferenceHash[$candidate]
            [PsObject] $homeTeam = New-Object -TypeName PsObject -Property @{
                $nameTeam = $candidate
                $nameConference = $conference
                $nameHome = $true
            }

            Write-Verbose "Home team:  $homeTeam"
            $teamList += $homeTeam
        }
    }

    $teamList  # Will contain 0, 1, or 2 items...
}

#===main=======================================================================

# If the date is not fully specified, use yesterday.
if ( ($Year -eq 0) -or ($Month -eq 0) -or ($Day -eq 0)) {
    [System.DateTime] $now = Get-Date
    [System.DateTime] $yesterday = $now.AddDays(-1.0)
    $Year = $yesterday.Year
    $Month = $yesterday.Month
    $Day = $yesterday.Day
}


[string] $dateStamp = [string]::Format('{0:D4}-{1:D2}-{2:D2}', $Year, $Month, $Day)
[string] $csvResultFileName = "Results-$dateStamp.csv"
[bool] $bExists = Test-Path -Path $csvResultFileName
if ($bExists) {
    Clear-Content -Path $csvResultFileName
}

[string] $header = Get-CsvHeader
$header | Add-Content -Path $csvResultFileName

$conferenceNameList = $ConferenceHash.Keys
$conferenceNameList | Sort-Object | ForEach-Object {
    [string] $conferenceName = $_
    [int] $conferenceId = $ConferenceHash[$conferenceName]
    [string] $url = "http://sports.yahoo.com/college-basketball/scoreboard/?date=$dateStamp&conf=$conferenceId"

    Write-Host "$dateStamp`:  $ConferenceName"

    $wc = New-Object -TypeName System.Net.WebClient
    [string] $content = $wc.DownloadString($url)

    $nChars = $content.Length

    [string] $target = 'class="game  link"'
    [int] $idxSearch = 0
    [int] $idxFound = -1
    [int[]] $itemStartIndexList = @()
    [int[]] $itemEndIndexList = @()

    do {
        $idxFound = $content.IndexOf($target, $idxSearch)
        if ($idxFound -ge 0) {
            $itemStartIndexList += $idxFound
            $idxSearch = $idxFound + $target.Length
        }
    } while ($idxFound -ge 0)

    [int] $nFound = $itemStartIndexList.Count
    for ($i = 1; $i -lt $nFound; $i++) {
        $itemEndIndexList += $itemStartIndexList[$i] - 1
    }
    $itemEndIndexList += $content.Length - 1

    $resultParseZoneList = @()
    for ($i = 0; $i -lt $nFound; $i++) {
        $parseZone = New-Object -TypeName PSObject -Property @{
            startIndex = $itemStartIndexList[$i]
            length = $itemEndIndexList[$i] - $itemStartIndexList[$i]
        }

        $resultParseZoneList += $parseZone
    }

    [string[]] $gameUrlList = @()

    $resultParseZoneList | ForEach-Object {
        [string] $substring = $content.Substring($_.startIndex, $_.length)
        if ($substring -match '\s+data-url="(.+?)"\s+') {
            $gameUrl = $Matches[1]
            $gameUrlList += "http://sports.yahoo.com$gameUrl"
        }
    }

    $gameUrlList | ForEach-Object {
        [string] $gameUrl = $_
        [PsObject[]] $teamList = Get-TeamList -gameUrl $gameUrl -Verbose
        [int] $nTeams = @($teamList).Count
        if ($nTeams -eq 2) {
            [PsObject[]] $athleteRecordList = Get-BoxScoreContent -Url $gameUrl

            # Export as CSV.
            [string[]] $csv = @()
            [string] $row = ''

            $athleteRecordList | ForEach-Object {
                $row = Get-CsvRow -AthleteRecord $_
                $csv += $row
            }

            $csv | Add-Content -Path $csvResultFileName

        }
        else {
            Write-Host "Incomplete team list for $gameUrl."
        }
    }
}


[CmdletBinding()]

param(
    [string] $Path
)

Set-StrictMode -Version Latest

Write-Verbose "Aggregating $Path"

[string] $resultFile = '.\dataframe.txt'


function New-DataFrameHeader
{
    $sb = New-Object -TypeName 'System.Text.StringBuilder'

    $sb.Append('GameKey,') | Out-Null         # Game Key
    $sb.Append('Date,') | Out-Null            # Date
    $sb.Append('Team,') | Out-Null            # Team
    $sb.Append('TeamConference,') | Out-Null  # Team Conference
    $sb.Append('Win,') | Out-Null               # Win
    $sb.Append('Possessions,') | Out-Null       # Possessions
    $sb.Append('PointsScored,') | Out-Null      # Points Scored
    $sb.Append('OffensiveRating,') | Out-Null   # Offensive Rating
    $sb.Append('DefensiveRating,') | Out-Null   # Defensive Rating
    $sb.Append('FieldGoalEffectivity,') | Out-Null  # Field Goal Effectivity
    $sb.Append('FreeThrowFraction,') | Out-Null  # Free Throw Fraction
    $sb.Append('TwoPointFraction,') | Out-Null   # Two Point Fraction
    $sb.Append('ThreePointFraction,') | Out-Null # Three Point Fraction
    $sb.Append('PointDispersion,') | Out-Null    # Point Dispersion
    $sb.Append('Participants,') | Out-Null       # Participants
    $sb.Append('OffensiveRebounds,') | Out-Null  # Offensive Rebounds
    $sb.Append('DefensiveRebounds,') | Out-Null  # Defensive Rebounds
    $sb.Append('Steals,') | Out-Null         # Steals
    $sb.Append('BlockedShots,') | Out-Null   # Blocked Shots
    $sb.Append('PersonalFouls,') | Out-Null  # Personal Fouls
    $sb.Append('Opponent,') | Out-Null     # Opponent
    $sb.Append('OpponentConference,') | Out-Null       # Opponent Conference
    $sb.Append('OpponentPossessions,') | Out-Null        # Opponent Possessions
    $sb.Append('OpponentPointsScored,') | Out-Null       # Opponent Points Scored
    $sb.Append('OpponentOffensiveRating,') | Out-Null    # Opponent Offensive Rating
    $sb.Append('OpponentDefensiveRating,') | Out-Null    # Opponent Defensive Rating
    $sb.Append('OpponentFieldGoalEffectivity,') | Out-Null  # Opponent Field Goal Effectivity
    $sb.Append('OpponentFreeThrowFraction,') | Out-Null  # Opponent Free Throw Fraction
    $sb.Append('OpponentTwoPointFraction,') | Out-Null   # Opponent Two Point Fraction
    $sb.Append('OpponentThreePointFraction,') | Out-Null # Opponent Three Point Fraction
    $sb.Append('OpponentPointDispersion,') | Out-Null    # Opponent Point Dispersion
    $sb.Append('OpponentParticipants,')  | Out-Null      # Opponent Participants
    $sb.Append('OpponentOffensiveRebounds,') | Out-Null  # Opponent Offensive Rebounds
    $sb.Append('OpponentDefensiveRebounds,') | Out-Null  # Opponent Defensive Rebounds
    $sb.Append('OpponentSteals,') | Out-Null             # Opponent Steals
    $sb.Append('OpponentBlockedShots,')  | Out-Null      # Opponent Blocked Shots
    $sb.Append('OpponentPersonalFouls') | Out-Null       # Opponent Personal Fouls

    [string] $dataFrameHeader = $sb.ToString()

    $dataFrameHeader
}


function New-DataFrameRow
{
    param(
        [PsObject[]] $teamSummaryList
    )

    # Create a data frame row.
    # The team is the first in the $teamSummaryList.
    # The opponent is the second in the $teamSummaryList.
    [string] $GameKey = $teamSummaryList[0].$nameGameKey
    [string] $Date = $teamSummaryList[0].$nameDate
    [string] $Team = $teamSummaryList[0].$nameTeam
    [string] $TeamConference = $teamSummaryList[0].$nameConference
    [int] $Win = $teamSummaryList[0].$nameWin
    [int] $Possessions = $teamSummaryList[0].$namePossessions
    [int] $PointsScored = $teamSummaryList[0].$namePointsScored
    [double] $OffensiveRating = $teamSummaryList[0].$nameOffensiveRating
    [double] $DefensiveRating = $teamSummaryList[0].$nameDefensiveRating
    [double] $FieldGoalEffectivity = $teamSummaryList[0].$nameFieldGoalEffectivity
    [double] $FreeThrowFraction = $teamSummaryList[0].$nameFreeThrowFraction
    [double] $TwoPointFraction = $teamSummaryList[0].$nameTwoPointFraction
    [double] $ThreePointFraction = $teamSummaryList[0].$nameThreePointFraction
    [double] $PointDispersion = $teamSummaryList[0].$namePointsDispersion
    [int] $Participants = $teamSummaryList[0].$nameParticipants
    [int] $OffensiveRebounds = $teamSummaryList[0].$nameOffensiveRebounds
    [int] $DefensiveRebounds = $teamSummaryList[0].$nameDefensiveRebounds
    [int] $Steals = $teamSummaryList[0].$nameSteals
    [int] $BlockedShots = $teamSummaryList[0].$nameBlockedShots
    [int] $PersonalFouls = $teamSummaryList[0].$namePersonalFouls
    [string] $Opponent = $teamSummaryList[1].$nameTeam
    [string] $OpponentConference = $teamSummaryList[1].$nameConference
    [int] $OpponentPossessions = $teamSummaryList[1].$namePossessions
    [int] $OpponentPointsScored = $teamSummaryList[1].$namePointsScored
    [double] $OpponentOffensiveRating = $teamSummaryList[1].$nameOffensiveRating
    [double] $OpponentDefensiveRating = $teamSummaryList[1].$nameDefensiveRating
    [double] $OpponentFieldGoalEffectivity = $teamSummaryList[1].$nameFieldGoalEffectivity
    [double] $OpponentFreeThrowFraction = $teamSummaryList[1].$nameFreeThrowFraction
    [double] $OpponentTwoPointFraction = $teamSummaryList[1].$nameTwoPointFraction
    [double] $OpponentThreePointFraction = $teamSummaryList[1].$nameThreePointFraction
    [double] $OpponentPointDispersion = $teamSummaryList[1].$namePointsDispersion
    [int] $OpponentParticipants = $teamSummaryList[1].$nameParticipants
    [int] $OpponentOffensiveRebounds = $teamSummaryList[1].$nameOffensiveRebounds
    [int] $OpponentDefensiveRebounds = $teamSummaryList[1].$nameDefensiveRebounds
    [int] $OpponentSteals = $teamSummaryList[1].$nameSteals
    [int] $OpponentBlockedShots = $teamSummaryList[1].$nameBlockedShots
    [int] $OpponentPersonalFouls = $teamSummaryList[1].$namePersonalFouls

    $sb = New-Object -TypeName 'System.Text.StringBuilder'

    $sb.Append("$GameKey,") | Out-Null         # Game Key
    $sb.Append("$Date,") | Out-Null            # Date
    $sb.Append("$Team,") | Out-Null            # Team
    $sb.Append("$TeamConference,") | Out-Null  # Team Conference
    $sb.Append("$Win,") | Out-Null               # Win
    $sb.Append("$Possessions,") | Out-Null       # Possessions
    $sb.Append("$PointsScored,") | Out-Null      # Points Scored
    $sb.Append("$OffensiveRating,") | Out-Null   # Offensive Rating
    $sb.Append("$DefensiveRating,") | Out-Null   # Defensive Rating
    $sb.Append("$FieldGoalEffectivity,") | Out-Null  # Field Goal Effectivity
    $sb.Append("$FreeThrowFraction,") | Out-Null  # Free Throw Fraction
    $sb.Append("$TwoPointFraction,") | Out-Null   # Two Point Fraction
    $sb.Append("$ThreePointFraction,") | Out-Null # Three Point Fraction
    $sb.Append("$PointDispersion,") | Out-Null    # Point Dispersion
    $sb.Append("$Participants,") | Out-Null       # Participants
    $sb.Append("$OffensiveRebounds,") | Out-Null  # Offensive Rebounds
    $sb.Append("$DefensiveRebounds,") | Out-Null  # Defensive Rebounds
    $sb.Append("$Steals,") | Out-Null         # Steals
    $sb.Append("$BlockedShots,") | Out-Null   # Blocked Shots
    $sb.Append("$PersonalFouls,") | Out-Null  # Personal Fouls
    $sb.Append("$Opponent,") | Out-Null     # Opponent
    $sb.Append("$OpponentConference,") | Out-Null       # Opponent Conference
    $sb.Append("$OpponentPossessions,") | Out-Null        # Opponent Possessions
    $sb.Append("$OpponentPointsScored,") | Out-Null       # Opponent Points Scored
    $sb.Append("$OpponentOffensiveRating,")  | Out-Null   # Opponent Offensive Rating
    $sb.Append("$OpponentDefensiveRating,") | Out-Null    # Opponent Defensive Rating
    $sb.Append("$OpponentFieldGoalEffectivity,") | Out-Null  # Opponent Field Goal Effectivity
    $sb.Append("$OpponentFreeThrowFraction,") | Out-Null  # Opponent Free Throw Fraction
    $sb.Append("$OpponentTwoPointFraction,") | Out-Null   # Opponent Two Point Fraction
    $sb.Append("$OpponentThreePointFraction,") | Out-Null # Opponent Three Point Fraction
    $sb.Append("$OpponentPointDispersion,") | Out-Null    # Opponent Point Dispersion
    $sb.Append("$OpponentParticipants,") | Out-Null       # Opponent Participants
    $sb.Append("$OpponentOffensiveRebounds,") | Out-Null  # Opponent Offensive Rebounds
    $sb.Append("$OpponentDefensiveRebounds,") | Out-Null  # Opponent Defensive Rebounds
    $sb.Append("$OpponentSteals,") | Out-Null             # Opponent Steals
    $sb.Append("$OpponentBlockedShots,") | Out-Null       # Opponent Blocked Shots
    $sb.Append("$OpponentPersonalFouls") | Out-Null       # Opponent Personal Fouls

    [string] $dataFrameRow = $sb.ToString()

    # Remove all spaces.
    $dataFrameRow = $dataFrameRow -replace '\s+', ''

    $dataFrameRow
}



$TeamNameConferenceHash =
@{
    'Abilene Christian' = 'Southland'
    'Air Force' = 'Mountain West'
    'Akron' = 'Mid-American'
    'Alabama A&M' = 'Southwestern Athletic'
    'Alabama' = 'Southeastern'
    'Alabama St.' = 'Southwestern Athletic'
    'Albany' = 'America East'
    'Alcorn St.' = 'Southwestern Athletic'
    'American' = 'Patriot League'
    'Appalachian St.' = 'Southern'
    'Arizona St.' = 'Pac-12'
    'Arizona' = 'Pac-12'
    'Arkansas' = 'Southeastern'
    'Arkansas St.' = 'Sun Belt'
    'AR Little Rock' = 'Sun Belt'
    'Army' = 'Patriot League'
    'Auburn' = 'Southeastern'
    'Austin Peay' = 'Ohio Valley'
    'Ball St.' = 'Mid-American'
    'Baylor' = 'Big 12'
    'Belmont' = 'Ohio Valley'
    'Bethune-Cookman' = 'Mid-Eastern'
    'Binghamton' = 'America East'
    'Boise St.' = 'Mountain West'
    'Boston Coll.' = 'Atlantic Coast'
    'Boston U.' = 'Patriot League'
    'Bowling Green' = 'Mid-American'
    'Bradley' = 'Missouri Valley'
    'Brown' = 'Ivy League'
    'Bryant' = 'Northeast'
    'Bucknell' = 'Patriot League'
    'Buffalo' = 'MidAmerican'
    'Butler' = 'Big East'
    'BYU' = 'West Coast'
    'Cal Poly' = 'Big West'
    'CSU Fullerton' = 'Big West'
    'CSU Northridge' = 'Big West'
    'California' = 'Pac-12'
    'Campbell' = 'Big South'
    'Canisius' = 'Metro Atlantic Athletic'
    'Central Arkansas' = 'Southland'
    'central Conn. St.' = 'Northeast'
    'Cent. Michigan' = 'MidAmerican'
    'Charleston' = 'Colonial Athletic'
    'Charleston Sou.' = 'Big South'
    'Charlotte' = 'Conference USA'
    'Chattanooga' = 'Southern'
    'Chicago St.' = 'Western Athletic'
    'Cincinnati' = 'American Athletic'
    'Citadel' = 'Southern'
    'Clemson' = 'Atlantic Coast'
    'Cleveland St.' = 'Horizon League'
    'Coastal Carolina' = 'Big South'
    'Colgate' = 'Patriot League'
    'Colorado' = 'Pac-12'
    'Colorado St.' = 'Mountain West'
    'Columbia' = 'Ivy League'
    'Connecticut' = 'American Athletic'
    'Coppin St.' = 'MidEastern'
    'Cornell' = 'Ivy League'
    'Creighton' = 'Big East'
    'CSU Bakersfield' = 'Western Athletic'
    'Dartmouth' = 'Ivy League'
    'Davidson' = 'Southern'
    'Dayton' = 'Atlantic Ten'
    'Delaware' = 'Colonial Athletic'
    'Delaware St.' = 'MidEastern'
    'Denver' = 'Summit'
    'DePaul' = 'Big East'
    'Detroit' = 'Horizon League'
    'Drake' = 'Missouri Valley'
    'Drexel' = 'Colonial Athletic'
    'Duke' = 'Atlantic Coast'
    'Duquesne' = 'Atlantic Ten'
    'East Carolina' = 'Conference USA'
    'easttennesseestate' = 'Atlantic Sun'
    'Eastern Illinois' = 'Ohio Valley'
    'Eastern Kentucky' = 'Ohio Valley'
    'East. Michigan' = 'MidAmerican'
    'Eastern Wash.' = 'Big Sky'
    'Elon' = 'Southern'
    'Evansville' = 'Missouri Valley'
    'Fairfield' = 'Metro Atlantic Athletic'
    'Fair. Dickinson' = 'Northeast'
    'Fla Gulf Coast' = 'Atlantic Sun'
    'Florida Intl.' = 'Conference USA'
    'Florida A&M' = 'MidEastern'
    'Florida Atlantic' = 'Conference USA'
    'Florida' = 'Southeastern'
    'Florida St.' = 'Atlantic Coast'
    'Fordham' = 'Atlantic Ten'
    'Fresno St.' = 'Mountain West'
    'Furman' = 'Southern'
    'Gardner-Webb' = 'Big South'
    'George Mason' = 'Atlantic Ten'
    'Geo. Washington' = 'Atlantic Ten'
    'Georgetown' = 'Big East'
    'Georgia' = 'Southeastern'
    'Georgia Southern' = 'Southern'
    'Georgia St.' = 'Sun Belt'
    'Georgia Tech' = 'Atlantic Coast'
    'Gonzaga' = 'West Coast'
    'Grambling St.' = 'Southwestern Athletic'
    'Grand Canyon' = 'Western Athletic'
    'Green Bay' = 'Horizon League'
    'Hampton' = 'MidEastern'
    'Hartford' = 'America East'
    'Harvard' = 'Ivy League'
    'Hawaii' = 'Big West'
    'High Point' = 'Big South'
    'Hofstra' = 'Colonial Athletic'
    'Holy Cross' = 'Patriot League'
    'Houston Baptist' = 'Southland'
    'Houston' = 'American Athletic'
    'Howard' = 'MidEastern'
    'Idaho St.' = 'Big Sky'
    'Idaho' = 'Western Athletic'
    'Illinois' = 'Big Ten'
    'Illinois St.' = 'Missouri Valley'
    'Incarnate Word' = 'Southland'
    'Indiana' = 'Big Ten'
    'Indiana St.' = 'Missouri Valley'
    'Iona' = 'Metro Atlantic Athletic'
    'Iowa' = 'Big Ten'
    'Iowa St.' = 'Big 12'
    'IPFW' = 'Summit'
    'IUPUI' = 'Summit'
    'Jackson St.' = 'Southwestern Athletic'
    'Jacksonville' = 'Atlantic Sun'
    'Jacksonville St.' = 'Ohio Valley'
    'James Madison' = 'Colonial Athletic'
    'Kansas' = 'Big 12'
    'Kansas St.' = 'Big 12'
    'Kennesaw St.' = 'Atlantic Sun'
    'Kent St.' = 'MidAmerican'
    'Kentucky' = 'Southeastern'
    'La Salle' = 'Atlantic Ten'
    'Lafayette' = 'Patriot League'
    'Lamar' = 'Southland'
    'Lehigh' = 'Patriot League'
    'Liberty' = 'Big South'
    'Lipscomb' = 'Atlantic Sun'
    'LIU Brooklyn' = 'Northeast'
    'Long Beach St.' = 'Big West'
    'Longwood' = 'Big South'
    'LA Monroe' = 'Sun Belt'
    'LA Lafayette' = 'Sun Belt'
    'Louisiana Tech' = 'Conference USA'
    'Louisville' = 'American Athletic'
    'Loyola Chicago' = 'Missouri Valley'
    'Loyola (MD)' = 'Patriot League'
    'Loyola Marymount' = 'West Coast'
    'LSU' = 'Southeastern'
    'Maine' = 'America East'
    'Manhattan' = 'Metro Atlantic Athletic'
    'Marist' = 'Metro Atlantic Athletic'
    'Marquette' = 'Big East'
    'Marshall' = 'Conference USA'
    'MD Eastern Shore' = 'MidEastern'
    'Maryland' = 'Atlantic Coast'
    'Mass-Lowell' = 'America East'
    'Massachusetts' = 'Atlantic Ten'
    'McNeese St.' = 'Southland'
    'Memphis' = 'American Athletic'
    'Mercer' = 'Atlantic Sun'
    'Miami (FL)' = 'Atlantic Coast'
    'Miami (OH)' = 'MidAmerican'
    'Michigan St.' = 'Big Ten'
    'Michigan' = 'Big Ten'
    'Middle Tenn. St.' = 'Conference USA'
    'Wis. Milwaukee' = 'Horizon League'
    'Minnesota' = 'Big Ten'
    'Mississippi St.' = 'Southeastern'
    'Miss. Valley St.' = 'Southwestern Athletic'
    'Missouri St.' = 'Missouri Valley'
    'Missouri' = 'Southeastern'
    'Monmouth' = 'Metro Atlantic Athletic'
    'Montana' = 'Big Sky'
    'Montana St.' = 'Big Sky'
    'Morehead St.' = 'Ohio Valley'
    'Morgan St.' = 'MidEastern'
    "Mount St. Mary's" = 'Northeast'
    'Murray St.' = 'Ohio Valley'
    'Navy' = 'Patriot League'
    'Nebraska' = 'Big Ten'
    'Nebraska Omaha' = 'Summit'
    'Nevada' = 'Mountain West'
    'New Hampshire' = 'America East'
    'New Mexico' = 'Mountain West'
    'N. Mexico St.' = 'Western Athletic'
    'New Orleans' = 'Southland'
    'Niagara' = 'Metro Atlantic Athletic'
    'Nicholls' = 'Southland'
    'N.J.I.T.' = 'Independents'
    'Norfolk St.' = 'MidEastern'
    'N.C. A&T' = 'MidEastern'
    'N.C. Central' = 'MidEastern'
    'N.C. State' = 'Atlantic Coast'
    'North Carolina' = 'Atlantic Coast'
    'North Dakota' = 'Big Sky'
    'North Dakota St.' = 'Summit'
    'North Florida' = 'Atlantic Sun'
    'North Texas' = 'Conference USA'
    'Northeastern' = 'Colonial Athletic'
    'Northern Arizona' = 'Big Sky'
    'Northern Colorado' = 'Big Sky'
    'Northern Illinois' = 'MidAmerican'
    'North. Kentucky' = 'Atlantic Sun'
    "N'western St." = 'Southland'
    'Northwestern' = 'Big Ten'
    'Notre Dame' = 'Atlantic Coast'
    'Oakland' = 'Horizon League'
    'Ohio' = 'MidAmerican'
    'Ohio St.' = 'Big Ten'
    'Oklahoma' = 'Big 12'
    'Oklahoma St.' = 'Big 12'
    'Old Dominion' = 'Conference USA'
    'Mississippi' = 'Southeastern'
    'Oral Roberts' = 'Southland'
    'Oregon' = 'Pac-12'
    'Oregon St.' = 'Pac-12'
    'Pacific' = 'West Coast'
    'Pennsylvania' = 'Ivy League'
    'Penn St.' = 'Big Ten'
    'Pepperdine' = 'West Coast'
    'Pittsburgh' = 'Atlantic Coast'
    'Portland' = 'West Coast'
    'Portland St.' = 'Big Sky'
    'Prairie View A&M' = 'Southwestern Athletic'
    'Presbyterian' = 'Big South'
    'Princeton' = 'Ivy League'
    'Providence' = 'Big East'
    'Purdue' = 'Big Ten'
    'Quinnipiac' = 'Metro Atlantic Athletic'
    'Radford' = 'Big South'
    'Rhode Island' = 'Atlantic Ten'
    'Rice' = 'Conference USA'
    'Richmond' = 'Atlantic Ten'
    'Rider' = 'Metro Atlantic Athletic'
    'Robert Morris' = 'Northeast'
    'Rutgers' = 'American Athletic'
    'Sacramento St.' = 'Big Sky'
    'Sacred Heart' = 'Northeast'
    'St. Francis (PA)' = 'Northeast'
    "St. Joseph's" = 'Atlantic Ten'
    'Saint Louis' = 'Atlantic Ten'
    "St. Mary's" = 'West Coast'
    "St. Peter's" = 'Metro Atlantic Athletic'
    'Sam Houston St.' = 'Southland'
    'Samford' = 'Southern'
    'San Diego St.' = 'Mountain West'
    'San Diego' = 'West Coast'
    'San Francisco' = 'West Coast'
    'San Jose St.' = 'Mountain West'
    'Santa Clara' = 'West Coast'
    'Savannah St.' = 'MidEastern'
    'Seattle' = 'Western Athletic'
    'Seton Hall' = 'Big East'
    'Siena' = 'Metro Atlantic Athletic'
    'SIU Edwardsville' = 'Ohio Valley'
    'SMU' = 'American Athletic'
    'South Alabama' = 'Sun Belt'
    'South Carolina' = 'Southeastern'
    'S. Carolina St.' = 'MidEastern'
    'S.Car. Upstate' = 'Atlantic Sun'
    'South Dakota' = 'Summit'
    'S. Dakota St.' = 'Summit'
    'South Florida' = 'American Athletic'
    'SE Louisiana' = 'Southland'
    'SE Missouri St.' = 'Ohio Valley'
    'Southern Ill.' = 'Missouri Valley'
    'Southern Miss' = 'Conference USA'
    'Southern' = 'Southwestern Athletic'
    'Southern Utah' = 'Big Sky'
    'St. Bonaventure' = 'Atlantic Ten'
    'St. Francis (NY)' = 'Northeast'
    "St. John's" = 'Big East'
    'Stanford' = 'Pac-12'
    'Stephen F. Austin' = 'Southland'
    'Stetson' = 'Atlantic Sun'
    'Stony Brook' = 'America East'
    'Syracuse' = 'Atlantic Coast'
    'TCU' = 'Big 12'
    'Temple' = 'American Athletic'
    'Tennessee St.' = 'Ohio Valley'
    'Tennessee Tech' = 'Ohio Valley'
    'Tennessee' = 'Southeastern'
    'Texas A&M' = 'Southeastern'
    'TAMU Corpus Christi' = 'Southland'
    'Texas' = 'Big 12'
    'TX Pan American' = 'Western Athletic'
    'Texas Southern' = 'Southwestern Athletic'
    'Texas St.' = 'Sun Belt'
    'Texas Tech' = 'Big 12'
    'Toledo' = 'MidAmerican'
    'Towson' = 'Colonial Athletic'
    'Troy' = 'Sun Belt'
    'Tulane' = 'Conference USA'
    'Tulsa' = 'Conference USA'
    'UAB' = 'Conference USA'
    'AR Pine Bluff' = 'Southwestern Athletic'
    'UC Davis' = 'Big West'
    'UC Irvine' = 'Big West'
    'UC Riverside' = 'Big West'
    'UCSB' = 'Big West'
    'UCF' = 'American Athletic'
    'UCLA' = 'Pac-12'
    'Ill. Chicago' = 'Horizon League'
    'UMBC' = 'America East'
    'Mo. Kansas City' = 'Western Athletic'
    'N.C. Asheville' = 'Big South'
    'N.C. Wilmington' = 'Colonial Athletic'
    'Northern Iowa' = 'Missouri Valley'
    'UNLV' = 'Mountain West'
    'USC' = 'Pac-12'
    'S.Car.Upstate' = 'Atlantic Sun'
    'TX Arlington' = 'Sun Belt'
    'Tenn-Martin' = 'Ohio Valley'
    'Utah' = 'Pac-12'
    'Utah St.' = 'Mountain West'
    'Utah Valley' = 'Western Athletic'
    'UTEP' = 'Conference USA'
    'UTSA' = 'Conference USA'
    'Valparaiso' = 'Horizon League'
    'Vanderbilt' = 'Southeastern'
    'VCU' = 'Atlantic Ten'
    'Vermont' = 'America East'
    'Villanova' = 'Big East'
    'Virginia' = 'Atlantic Coast'
    'Virginia Tech' = 'Atlantic Coast'
    'Virginia Military' = 'Big South'
    'Wagner' = 'Northeast'
    'Wake Forest' = 'Atlantic Coast'
    'Washington' = 'Pac-12'
    'Washington St.' = 'Pac-12'
    'Weber St.' = 'Big Sky'
    'West Virginia' = 'Big 12'
    'western Carolina' = 'Southern'
    'Western Ill.' = 'Summit'
    'W. Kentucky' = 'Sun Belt'
    'W. Michigan' = 'MidAmerican'
    'Wichita St.' = 'Missouri Valley'
    'William & Mary' = 'Colonial Athletic'
    'Winthrop' = 'Big South'
    'Wisconsin' = 'Big Ten'
    'Wofford' = 'Southern'
    'Wright St.' = 'Horizon League'
    'Wyoming' = 'Mountain West'
    'Xavier' = 'Big East'
    'Yale' = 'Ivy League'
    'Youngstown St.' = 'Horizon League'
}



function Get-DateFromGameKey
{
    param( [string] $gameKey )

    [string] $dateStamp = ''
    [string[]] $tokens = $gameKey -split '-'
    [int] $idxDateToken = $tokens.Count - 1

    [bool] $bMatch = $tokens[$idxDateToken] -match '^\d\d\d\d\d\d\d\d'
    if ($bMatch) {
        $dateStamp = $Matches[0]
    }

    $dateStamp
}



#---main-----------------------------------------------------------------------

[string] $nameGameKey = 'GameKey'
[string] $nameDate = 'Date'
[string] $nameTeam = 'Team'
[string] $nameFieldGoalsMade = 'FieldGoalsMade'
[string] $nameFieldGoalsAttempted = 'FieldGoalsAttempted'
[string] $nameThreePointersMade = 'threePointersMade'
[string] $nameThreePointersAttempted = 'ThreePointersAttempted'
[string] $nameFreeThrowsMade = 'FreeThrowsMade'
[string] $nameFreeThrowsAttempted = 'FreeThrowsAttempted'
[string] $nameOffensiveRebounds = 'OffensiveRebounds'
[string] $nameDefensiveRebounds = 'DefensiveRebounds'
[string] $nameTotalRebounds = 'TotalRebounds'
[string] $nameAssists = 'Assists'
[string] $nameTurnovers = 'Turnovers'
[string] $nameSteals = 'Steals'
[string] $nameBlockedShots = 'BlockedShots'
[string] $namePersonalFouls = 'PersonalFouls'
[string] $nameConference = 'Conference'
[string] $namePointsScored = 'PointsScored'
[string] $namePointsAllowed = 'PointsAllowed'
[string] $nameWin = 'Win'
[string] $namePointsDispersion = 'PointsDispersion'
[string] $namePossessions = 'Possessions'
[string] $nameParticipants = 'Participants'
[string] $nameOffensiveRating = 'OffensiveRating'
[string] $nameDefensiveRating = 'DefensiveRating'
[string] $nameFieldGoalEffectivity = 'FieldGoalEffectivity'
[string] $nameBenchPointsFraction = 'BenchPointsFraction'
[string] $nameTwoPointFraction = 'TwoPointFraction'
[string] $nameThreePointFraction = 'ThreePointFraction'
[string] $nameFreeThrowFraction = 'FreeThrowFraction'
[string] $nameOpponent = 'Opponent'

[string[]] $uniqContent = Get-Content -Path $Path | Sort-Object | Get-Unique
[string] $uniqContentPath = '.\uniq.csv'
$uniqContent | Set-Content -Path $uniqContentPath

# Data frame rows stored here.
[string[]] $dataFrameRowList = @()

# Import the specified CSV file and convert it to an array of PsObjects.
[PsObject[]] $boxScoreRowList = Import-Csv -Path $uniqContentPath

# Get the sort list of unique gameKey values from the box score row list.
[string[]] $gameKeyList = @()
$boxScoreRowList | ForEach-Object { $gameKeyList += $_.gameKey }
[string[]] $uniqGameKeyList = $gameKeyList | Sort-Object | Get-Unique

# Aggregate the rows by gameKey-college
$uniqGameKeyList | ForEach-Object {
    [string] $gameKey = $_

    [string] $date = Get-DateFromGameKey -gameKey $gameKey

    # This is a list of rows for the specified game key.
    $gameKeyRowList = @()
    $boxScoreRowList | ForEach-Object { if ($_.gameKey -eq $gameKey) { $gameKeyRowList += $_ } }

    # Group the game key rows by college.
    $groupList = $gameKeyRowList | Group-Object -Property college

    [PsObject[]] $teamSummaryList = @()

    $groupList | ForEach-Object {

        [int] $starterPointsScored = 0
        [int] $benchPointsScored = 0
        [int] $teamPointsScored = 0

        [int] $fieldGoalsMade = 0
        [int] $fieldGoalsAttempted = 0
        [int] $threePointersMade = 0
        [int] $threePointersAttempted = 0
        [int] $freeThrowsMade = 0
        [int] $freeThrowsAttempted = 0
        [int] $offensiveRebounds = 0
        [int] $defensiveRebounds = 0
        [int] $totalRebounds = 0
        [int] $assists = 0
        [int] $turnovers = 0
        [int] $steals = 0
        [int] $blockedShots = 0
        [int] $personalFouls = 0
        [int] $pointsScored = 0

        [string] $team = $_.Name
        [string] $conference = $TeamNameConferenceHash[$team]

        # Sort the rows by minutes (descending).
        # Assume that the five with highest minutes are starters.
        $sortedRows = $_.Group | Sort-Object { [int] $_.minutes } -Descending

        [int] $nPlayers = $sortedRows.Count
        # Determine starter points scored.
        for ($i = 0; $i -lt 5; $i++) {
            $starterPointsScored += $sortedRows[$i].pointsScored
        }

        # Determine bench points scored.
        for ($i = 5; $i -lt $nPlayers; $i++)
        {
            $benchPointsScored += $sortedRows[$i].pointsScored
        }

        $teamPointsScored = $starterPointsScored + $benchPointsScored

        # Determine scoring dispersion. (std dev)
        [double] $meanPointsScored = [double] $teamPointsScored / [double] $nPlayers
        [double] $variance = 0
        [double] $difference = 0
         $sortedRows | ForEach-Object {
            $difference = $_.$namePointsScored - $meanPointsScored
            $variance += $difference * $difference
        }

        [double] $stdev = [System.Math]::Sqrt( $variance / ($nPlayers - 1) )

        # Sum team results.
        $sortedRows | ForEach-Object {
            $fieldGoalsMade += $_.$nameFieldGoalsMade
            $fieldGoalsAttempted += $_.$nameFieldGoalsAttempted
            $threePointersMade += $_.$nameThreePointersMade
            $threePointersAttempted += $_.$nameThreePointersAttempted
            $freeThrowsMade += $_.$nameFreeThrowsMade
            $freeThrowsAttempted += $_.$nameFreeThrowsAttempted
            $offensiveRebounds += $_.$nameOffensiveRebounds
            $defensiveRebounds += $_.$nameDefensiveRebounds
            $totalRebounds += $_.$nameTotalRebounds
            $assists += $_.$nameAssists
            $turnovers += $_.$nameTurnovers
            $steals += $_.$nameSteals
            $blockedShots += $_.$nameBlockedShots
            $personalFouls += $_.$namePersonalFouls
            $pointsScored += $_.$namePointsScored
        }

        # Standard metrics:
        # http://en.wikipedia.org/wiki/APBRmetrics
        # Possessions = 0.96 * (FGA - OffReb + TO + (0.475 * FTA))
        # OffensiveRating = Pts Scored * 100 / Possessions
        # DefensiveRating = Pts Allowed * 100 / Possessions
        # EffectiveFieldGoalPercentage = (FGM + 0.5* 3FGM)/FGA
        # Rebound Rate

        [int] $possessions = [int] (0.96 * ($fieldGoalsAttempted - $offensiveRebounds + $turnovers + (0.475 * $freeThrowsAttempted)))
        [double] $offensiveRating = $pointsScored * 100.0 / $possessions
        [double] $defensiveRating = 0
        [double] $fieldGoalEffectivity = ($fieldGoalsMade + 0.5 * $threePointersMade) / $fieldGoalsAttempted
        [double] $benchPointsFraction = $benchPointsScored / $pointsScored
        [double] $twoPointFraction = 2 * ($fieldGoalsMade - $threePointersMade) / $pointsScored
        [double] $threePointFraction = 3 * $threePointersMade / $pointsScored
        [double] $freeThrowFraction = $freeThrowsMade / $pointsScored

        $teamSummary = New-Object -TypeName PsObject -Property @{
            $nameGameKey = $gameKey
            $nameDate = $date
            $nameTeam = $team
            $nameConference = $conference
            $namePointsScored = $pointsScored
            $namePointsAllowed = 0
            $nameWin = 0
            $namePossessions = $possessions
            $nameOffensiveRating = $offensiveRating
            $nameDefensiveRating = 0
            $nameFieldGoalEffectivity = $fieldGoalEffectivity
            $nameBenchPointsFraction = $benchPointsFraction
            $nameTwoPointFraction = $twoPointFraction
            $nameThreePointFraction = $threePointFraction
            $nameFreeThrowFraction = $freeThrowFraction
            $namePointsDispersion = $stdev
            $nameParticipants = $nPlayers
            $nameOffensiveRebounds = $offensiveRebounds
            $nameDefensiveRebounds = $defensiveRebounds
            $namePersonalFouls = $personalFouls
            $nameTurnovers = $turnovers
            $nameSteals = $steals
            $nameBlockedShots = $blockedShots
        }

        $teamSummaryList += $teamSummary
    }

    # Fix defensive stats here...
    # DefensiveRating = Pts Allowed * 100 / Possessions
    # Fix points allowed.
    $teamSummaryList[0].$namePointsAllowed = $teamSummaryList[1].$namePointsScored
    $teamSummaryList[1].$namePointsAllowed = $teamSummaryList[0].$namePointsScored

    $teamSummaryList | ForEach-Object {
         # Fix defensive rating.
        $_.$nameDefensiveRating = $_.$namePointsAllowed * 100 / $_.$namePossessions

        # Fix win-loss.
        if ($_.$namePointsScored -gt $_.$namePointsAllowed) {
            $_.$nameWin = 1
        }
    }

    # Create a data frame row.
    # The team is the first in the $teamSummaryList.
    # The opponent is the second in the $teamSummaryList.
    [string] $dataFrameRow = New-DataFrameRow -teamSummaryList $teamSummaryList
    $dataFrameRowList += $dataFrameRow
}


# Test if the result file exists.
[bool] $bExists = Test-Path -Path $resultFile

# If the result file does not exist, first put a header in it.
if ($bExists -eq $false) {
    $dataFrameHeader = New-DataFrameHeader
    $dataFrameHeader | Set-Content -Path $resultFile
}

# Write the data frame rows to the result file.
$dataFrameRowList | Add-Content -Path $resultFile

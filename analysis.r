# remove low contributors
setwd("c:/users/rod/skydrive/ncaa")
#setwd("c:/users/rodney.doe/skydrive/ncaa")
 plotFit <- function(yObserved, yFitted, intercept=0) {
  plot(yObserved, yFitted)
  abline(intercept, 1, lty=2, col=rgb(1,0,0))
}

df <- read.csv("dataframe.txt", header=TRUE)

#df$Margin = df$PointsScored - df$OpponentPointsScored
#model <- aov(Margin ~ TeamConference:OpponentConference, data = df)

model = lm(PointsScored ~
TeamConference +
Possessions +
OffensiveRating +
DefensiveRating +
PersonalFouls +
OpponentConference +
OpponentPossessions +
OpponentOffensiveRating +
OpponentDefensiveRating +
OpponentDefensiveRebounds +
OpponentSteals +
OpponentBlockedShots +
OpponentPersonalFouls, data=df)

plotFit(df$PointsScored, fitted(model))

getPossessions <- function(df, teamName) {
    df <- as.data.frame(df)
    Possessions <- c(df$Possessions[which(df$Team == teamName)],
                     df$OpponentPossessions[which(df$Opponent == teamName)])

    return(Possessions)
}


getOffensiveRatings <- function(df, teamName) {
    df <- as.data.frame(df)
    OffensiveRatings <- c(df$OffensiveRating[which(df$Team == teamName)],
                          df$OpponentOffensiveRating[which(df$Opponent == teamName)])

    return(OffensiveRatings)
}


getDefensiveRatings <- function(df, teamName) {
    df <- as.data.frame(df)
    DefensiveRatings <- c(df$DefensiveRating[which(df$Team == teamName)],
                          df$OpponentDefensiveRating[which(df$Opponent == teamName)])

    return(DefensiveRatings)
}


getDefensiveRebounds <- function(df, teamName) {
    df <- as.data.frame(df)
    DefensiveRebounds <- c(df$DefensiveRebounds[which(df$Team == teamName)],
                              df$OpponentDefensiveRebounds[which(df$Opponent == teamName)])
    return(DefensiveRebounds)
}


getPointDispersions <- function(df, teamName) {
    df <- as.data.frame(df)
    PointDispersions <- c(df$PointDispersion[which(df$Team == teamName)],
                          df$OpponentPointDispersion[which(df$Opponent == teamName)])

    return(PointDispersions)
}


getPersonalFouls <- function(df, teamName) {
    df <- as.data.frame(df)
    PersonalFouls <- c(df$PersonalFouls[which(df$Team == teamName)],
                       df$OpponentPersonalFouls[which(df$Opponent == teamName)])

    return(PersonalFouls)
}


getSteals <- function(df, teamName) {
    df <- as.data.frame(df)
    Steals <- c(df$Steals[which(df$Team == teamName)],
                df$OpponentSteals[which(df$Opponent == teamName)])

    return(Steals)
}


getBlockedShots <- function(df, teamName) {
    df <- as.data.frame(df)
    BlockedShots <- c(df$BlockedShots[which(df$Team == teamName)],
                      df$OpponentBlockedShots[which(df$Opponent == teamName)])

    return(BlockedShots)
}


getTeamConference <- function(df, teamName) {
    df <- as.data.frame(df)
    # Note:  Some teams (e.g. Washington) always sort as Opponent.
    # This makes the values appear as factor levels (a number).
    TeamConferences = df$TeamConference[which(df$Team == teamName)]
    if (length(TeamConferences) == 0) {
        TeamConferences = df$OpponentConference[which(df$Opponent == teamName)]
    }

    return(as.character(TeamConferences[1]))
}

predictWinner <- function(teamName, opponentName, df, model, nScenarios=10000)
{
    teamConference = getTeamConference(df, teamName)
    teamPossessions = getPossessions(df, teamName)
    teamOffensiveRatings = getOffensiveRatings(df, teamName)
    teamDefensiveRatings = getDefensiveRatings(df, teamName)
    teamDefensiveRebounds  = getDefensiveRebounds(df, teamName)
    teamSteals = getSteals(df, teamName)
    teamPersonalFouls = getPersonalFouls(df, teamName)
    teamBlockedShots = getBlockedShots(df, teamName)

    opponentConference = getTeamConference(df, opponentName)
    opponentPossessions = getPossessions(df, opponentName)
    opponentOffensiveRatings = getOffensiveRatings(df, opponentName)
    opponentDefensiveRatings = getDefensiveRatings(df, opponentName)
    opponentDefensiveRebounds  = getDefensiveRebounds(df, opponentName)
    opponentSteals = getSteals(df, opponentName)
    opponentPersonalFouls = getPersonalFouls(df, opponentName)
    opponentBlockedShots = getBlockedShots(df, opponentName)

    TeamConference = rep(teamConference, nScenarios)
    Possessions = sample(min(teamPossessions):max(teamPossessions), nScenarios, replace=TRUE)
    OffensiveRating = runif(nScenarios, min(teamOffensiveRatings ), max( teamOffensiveRatings ))
    DefensiveRating = runif(nScenarios, min(teamDefensiveRatings), max(teamDefensiveRatings))
    PersonalFouls = sample(min(teamPersonalFouls):max(teamPersonalFouls), nScenarios, replace=TRUE)
    OpponentConference = rep(opponentConference, nScenarios)
    OpponentPossessions = sample(min(opponentPossessions):max(opponentPossessions), nScenarios, replace=TRUE)
    OpponentOffensiveRating = runif(nScenarios, min(opponentOffensiveRatings), max(opponentOffensiveRatings))
    OpponentDefensiveRating = runif(nScenarios, min(opponentDefensiveRatings), max(opponentDefensiveRatings))
    OpponentDefensiveRebounds = runif(nScenarios, min(opponentDefensiveRebounds), max(opponentDefensiveRebounds))
    OpponentSteals = sample(min(opponentSteals):max(opponentSteals), nScenarios, replace=TRUE)
    OpponentBlockedShots = sample(min(opponentBlockedShots):max(opponentBlockedShots), nScenarios, replace=TRUE)
    OpponentPersonalFouls = sample(min(opponentPersonalFouls):max(opponentPersonalFouls), nScenarios, replace=TRUE)

    # Create data frame for team score prediction.
    dfpt = cbind.data.frame(
        TeamConference,
        Possessions,
        OffensiveRating,
        DefensiveRating,
        PersonalFouls,
        OpponentConference,
        OpponentPossessions,
        OpponentOffensiveRating,
        OpponentDefensiveRating,
        OpponentDefensiveRebounds,
        OpponentSteals,
        OpponentBlockedShots,
        OpponentPersonalFouls
    )

    teamPointsScored = round(predict(model, dfpt))

    # Create data frame for opponent score prediction.
    # Switch conferences
    x = OpponentConference
    OpponentConference = TeamConference
    TeamConference = x

    # Switch possessions
    x = OpponentPossessions
    OpponentPossessions = Possessions
    Possessions = x

    # Switch offensive ratings
    x = OpponentOffensiveRating
    OpponentOffensiveRating = OffensiveRating
    OffensiveRating = x

    # Switch defensive ratings
    x = OpponentDefensiveRating
    OpponentDefensiveRating = DefensiveRating
    DefensiveRating = x

    PersonalFouls = sample(min(opponentPersonalFouls):max(opponentPersonalFouls), nScenarios, replace=TRUE)

    OpponentDefensiveRebounds = runif(nScenarios, min(teamDefensiveRebounds), max(teamDefensiveRebounds))
    OpponentSteals = sample(min(teamSteals):max(teamSteals), nScenarios, replace=TRUE)
    OpponentBlockedShots = sample(min(teamBlockedShots):max(teamBlockedShots), nScenarios, replace=TRUE)
    OpponentPersonalFouls = sample(min(teamPersonalFouls):max(teamPersonalFouls), nScenarios, replace=TRUE)

    dfpo = cbind.data.frame(
        TeamConference,
        Possessions,
        OffensiveRating,
        DefensiveRating,
        PersonalFouls,
        OpponentConference,
        OpponentPossessions,
        OpponentOffensiveRating,
        OpponentDefensiveRating,
        OpponentDefensiveRebounds,
        OpponentSteals,
        OpponentBlockedShots,
        OpponentPersonalFouls
    )

    # Predict opponent points scored.
    opponentPointsScored = round(predict(model, dfpo))

    # Make a dataframe of points scored.  Not sure why...
    pointsScored = cbind.data.frame(teamPointsScored, opponentPointsScored)

    # Produce/report a result message.
    teamWins = pointsScored$teamPointsScored > pointsScored$opponentPointsScored
    msg = sprintf("%d scenarios of %s versus %s:", nScenarios, teamName, opponentName)
    print(msg)
    nTeamWins = length(which(teamWins == TRUE))
    nOpponentWins = nScenarios - nTeamWins
    if (nTeamWins > nOpponentWins) {
        msg = sprintf("%s wins %d scenarios.", teamName, nTeamWins)
    } else {
        msg = sprintf("%s wins %d scenarios.", opponentName, nOpponentWins)
    }
    print(msg)
	
	#return(pointsScored)
}

# unique(sort(c(levels(df$Team), levels(df$Opponent))))
# predictWinner('NorthCarolina', 'Duke', df, model)

print("Play-in round:")
predictWinner("Albany", "MountSt.Mary's", df, model)
predictWinner("N.C.State" , "Xavier", df, model)
predictWinner("CalPoly", "TexasSouthern" , df, model)
predictWinner("Iowa", "Tennessee", df, model)

print("First round:  South")
predictWinner("Albany", "Florida", df, model)
predictWinner("Colorado", "Pittsburgh", df, model)
predictWinner("VCU", "StephenF.Austin", df, model)
predictWinner("UCLA", "Tulsa", df, model)
predictWinner("OhioSt.", "Dayton", df, model)
predictWinner("Syracuse", "W.Michigan", df, model)
predictWinner("NewMexico", "Stanford", df, model)
predictWinner("Kansas", "EasternKentucky", df, model)

print("First round:  East")
predictWinner("Virginia", "CoastalCarolina", df, model)
predictWinner("Memphis", "Geo.Washington", df, model)
predictWinner("Cincinnati", "Harvard", df, model)
predictWinner("MichiganSt.", "Delaware", df, model)
predictWinner("NorthCarolina", "Providence", df, model)
predictWinner("IowaSt.", "N.C.Central", df, model)
predictWinner("Connecticut", "St.Joseph's", df, model)
predictWinner("Villanova", "Wis.Milwaukee", df, model)

print("First round:  West")
predictWinner("Arizona", "WeberSt.", df, model)
predictWinner("Gonzaga", "OklahomaSt.", df, model)
predictWinner("Oklahoma", "NorthDakotaSt.", df, model)
predictWinner("SanDiegoSt.", "N.MexicoSt.", df, model)
predictWinner("Baylor", "Nebraska", df, model)
predictWinner("Creighton", "Lafayette", df, model)
predictWinner("Oregon", "BYU", df, model)
predictWinner("Wisconsin", "American", df, model)

print("First round:  Midwest")
predictWinner("WichitaSt.", "CalPoly", df, model)
predictWinner("Kentucky", "KansasSt.", df, model)
predictWinner("SaintLouis", "N.C.State", df, model)
predictWinner("Louisville", "Manhattan", df, model)
predictWinner("Massachusetts", "Tennessee", df, model)
predictWinner("Duke", "Mercer", df, model)
predictWinner("Texas", "ArizonaSt.", df, model)
predictWinner("Michigan", "Wofford", df, model)

print("Second round:  South")
predictWinner("Florida", "Pittsburgh", df, model)
predictWinner("StephenF.Austin", "Tulsa", df, model)
predictWinner("OhioSt.", "Syracuse", df, model)
predictWinner("NewMexico", "Kansas", df, model)

print("Second round:  East")
predictWinner("Virginia", "Geo.Washington", df, model)
predictWinner("Harvard", "MichiganSt.", df, model)
predictWinner("Providence", "IowaSt.", df, model)
predictWinner("Connecticut", "Villanova", df, model)

print("Second round:  West")
predictWinner("Arizona", "OklahomaSt.", df, model)
predictWinner("NorthDakotaSt.", "SanDiegoSt.", df, model)
predictWinner("Baylor", "Creighton", df, model)
predictWinner("Oregon", "Wisconsin", df, model)


print("Second round:  Midwest")
predictWinner("WichitaSt.", "Kentucky", df, model)
predictWinner("SaintLouis", "Louisville", df, model)
predictWinner("Tennessee", "Duke", df, model)
predictWinner("ArizonaSt.", "Michigan", df, model)


print("Third round:  South")
predictWinner("Florida", "StephenF.Austin", df, model)
predictWinner("OhioSt.", "Kansas", df, model)

print("Third round:  East")
predictWinner("Geo.Washington", "MichiganSt.", df, model)
predictWinner("IowaSt.", "Connecticut", df, model)

print("Third round:  West")
predictWinner("Arizona", "SanDiegoSt.", df, model)
predictWinner("Creighton", "Oregon", df, model)

print("Third round:  Midwest")
predictWinner("WichitaSt.", "Louisville", df, model)
predictWinner("Duke", "Michigan", df, model)

print("Fourth round:  South")
predictWinner("Florida", "OhioSt.", df, model)

print("Fourth round:  East")
predictWinner("MichiganSt.", "Connecticut", df, model)

print("Fourth round:  West")
predictWinner("Arizona", "Oregon", df, model)

print("Fourth round:  Midwest")
predictWinner("Louisville", "Michigan", df, model)

print("Semifinals:")
predictWinner("Florida", "Connecticut", df, model)
predictWinner("Arizona", "Louisville", df, model)

print("Final:")
predictWinner("Florida", "Louisville", df, model)


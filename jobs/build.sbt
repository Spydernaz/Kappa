ThisBuild / scalaVersion := "2.13.4"
ThisBuild / organization := "com.spydernaz.streaming"

addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.6")

lazy val hello = (project in file("."))
  .settings(
    name := "Kappa",
    libraryDependencies += "com.typesafe.play" %% "play-json" % "2.6.9",
    libraryDependencies += "com.eed3si9n" %% "gigahorse-okhttp" % "0.3.1",
  )
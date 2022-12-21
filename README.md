# TostSerializer

[![GitHub release](https://img.shields.io/github/release/pharo-ide/TostSerializer.svg)](https://github.com/pharo-ide/TostSerializer/releases/latest)
[![Unit Tests](https://github.com/pharo-ide/TostSerializer/actions/workflows/tests.yml/badge.svg)](https://github.com/pharo-ide/TostSerializer/actions/workflows/tests.yml)

[![Pharo 7.0](https://img.shields.io/badge/Pharo-7.0-informational)](https://pharo.org)
[![Pharo 8.0](https://img.shields.io/badge/Pharo-8.0-informational)](https://pharo.org)
[![Pharo 9.0](https://img.shields.io/badge/Pharo-9.0-informational)](https://pharo.org)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-informational)](https://pharo.org)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-informational)](https://pharo.org)

TostSerializer is general object serialization library which allows you to transfer objects over binary streams. 

Tost is abbreviation from "<b>T</b>ransient <b>O</b>bject<b>s</b> <b>T</b>ransport" where transient transport means that resulted binary data is supposed to be used in time. Tost does not put any meta information on streams and does not support versioning and data migration.

Its goal is to provide a compact and an efficient way for objects serialization with ability to be optimized for concrete application usage.

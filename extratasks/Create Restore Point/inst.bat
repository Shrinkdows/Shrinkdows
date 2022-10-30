@echo off
wmic /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Before Shrinkdows Setup", 100, 7
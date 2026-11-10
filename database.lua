-- File: database.lua (Đã đầy đủ 100% tất cả script của bồ)
return {
    Main0 = {
        Title = "Main🗒️",
        Items = {
            {
                Type = "Button",
                Title = "Bảng tin update script và thông tin lặt vặt",
                Description = "(ngày 24 tháng 12) Script Banana and Gravity Fixed, +1 script bloxfruit",
                Callback = function()
                    if setclipboard then setclipboard("đã là bảng tin thì k có link đou") end
                end
            },
            {
                Type = "Button",
                Title = "Tổng Hợp Game 2❤️",
                Description = "Ủng hộ đê nhìn j",
                Callback = function()
                    if setclipboard then setclipboard("tiktok.com/@tonghopgamemoimatacc") end
                end
            },
            {
                Type = "Button",
                Title = "Kênh Youtube📚",
                Description = "ít làm video",
                Callback = function()
                    if setclipboard then setclipboard("https://www.youtube.com/@T%E1%BB%95ngH%E1%BB%A3pgame2-v4i") end
                end
            },
            {
                Type = "Button",
                Title = "Discord",
                Description = "(Coming Soon) ✌️",
                Callback = function()
                    if setclipboard then setclipboard("Cố chấp ghê á?") end
                end
            }
        }
    },
    Main1 = {
        Title = "BloxFruit⚔️",
        Items = {
            {
                Type = "Loadstring",
                Title = "GravityHub",
                Description = "Script này ngon load nhanh hơn nhiều rồi",
                Url = "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = "Pirates", Translator = true }
                end
            },
            {
                Type = "Loadstring",
                Title = "Script TeddyHubFarm",
                Description = "script này có giao diện giống tới 80-90% banana nhma hạng free thì sao mà bằng đc v là ngon lắm r",
                Url = "https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua",
                PreFunc = function()
                    repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
                end
            },
            {
                Type = "Loadstring",
                Title = "HoangLongHub",
                Description = "Script này k biết ngon không nhma giao diện giống mà khác tính năng với màu của banana hub premium",
                Url = "https://raw.githubusercontent.com/longdwieh/HoangLong-script/refs/heads/main/HoangLongHub.lua.txt",
                PreFunc = function()
                    getgenv().Team = "Marines"
                end
            },
            {
                Type = "Loadstring",
                Title = "AryaHubKaitun",
                Description = "Không có sài kaitun nhiều nên tự mà trải nghiệm",
                Url = "https://raw.githubusercontent.com/hhl29042008-ops/script/refs/heads/main/cac",
                PreFunc = function()
                    Config = {
                        Team = "Pirates",
                        Configuration = { HopWhenIdle = true, AutoHop = true, AutoHopDelay = 60 * 60, FpsBoost = false, BlackScreen = true },
                        Items = { AutoFullyMelees = true, Saber = true, CursedDualKatana = false, SoulGuitar = false, RaceV2 = true },
                        Settings = { StayInSea2UntilHaveDarkFragments = false }
                    }
                end
            },
            {
                Type = "Loadstring",
                Title = "HiruHub",
                Description = "Script này cũng ổn nhma tùy=)))",
                Url = "https://raw.githubusercontent.com/KiddoHiru/BloxFruits/main/Source.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "W-azure",
                Description = "Script này này ngon nhá=)",
                Url = "https://api.luarmor.net/files/v3/loaders/85e904ae1ff30824c1aa007fc7324f8f.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "RiseEvoHub",
                Description = "Script này thì cx chả nhớ cái j đâu nên tự mà kiểm tra nhá",
                Url = "https://raw.githubusercontent.com/TrashLua/BloxFruits/main/loadder.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                    getgenv().Team = "Pirates"
                end
            },
            {
                Type = "Loadstring",
                Title = "BlueXHub",
                Description = "Script này sẵn sea event mà tìm thì khó ",
                Url = "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"
            },
            {
                Type = "Loadstring",
                Title = "Script Ngọc Bổng",
                Description = "Script Farm cày boss elite ngon ",
                Url = "https://raw.githubusercontent.com/ngocbonggaming/script/refs/heads/main/NgocBongVn.lua",
                PreFunc = function()
                    getgenv().Team = "Marines"
                end
            },
            {
                Type = "Loadstring",
                Title = "GodHub",
                Description = "Script này thì na ná script RedzHub fake thui cx ổn",
                Url = "https://raw.githubusercontent.com/shinichi-dz/phucshinsayhi/refs/heads/main/Loader.lua",
                PreFunc = function()
                    repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
                end
            },
            {
                Type = "Loadstring",
                Title = "MaruHubPreFake",
                Description = "Script MaruHubPreFake sài tạm ổn",
                Url = "https://raw.githubusercontent.com/hnc-roblox/Free/refs/heads/main/MaruHubPremiumFake.HNC%20Roblox.lua"
            },
            {
                Type = "Loadstring",
                Title = "Script DatThgV1",
                Description = "Script này k phải của tui nhá mà là của idol khác",
                Url = "https://raw.githubusercontent.com/LuaCrack/DatThg/refs/heads/main/DatThgV1"
            },
            {
                Type = "Loadstring",
                Title = "Script MinV27",
                Description = "Nền xanh lá sài cx ổn👍 ",
                Url = "https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinUp27Vn",
                PreFunc = function()
                    getgenv().Team = "Marines"
                end
            },
            {
                Type = "Loadstring",
                Title = "VxezeHub",
                Description = "Script này chx test sâu cho lắm nên k bt",
                Url = "https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain"
            },
            {
                Type = "Loadstring",
                Title = "RedzHub",
                Description = "Script Fake Redz mà sài cx ngon lắm à nhá",
                Url = "https://raw.githubusercontent.com/luraobermeyer-jpg/redzhub/refs/heads/main/redzhub.lua.txt"
            },
            {
                Type = "Loadstring",
                Title = "Script Tsuo",
                Description = "Script Gambling ý là cái menu nó sẽ ra á",
                Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"
            },
            {
                Type = "Loadstring",
                Title = "OMGHub",
                Description = "Script cx ổn nhma CẦN KEY NHÁ nhớ nhá",
                Url = "https://api.luarmor.net/files/v3/loaders/479e9f38148118df2d14fc0795ece576.lua"
            },
            {
                Type = "Loadstring",
                Title = "TrẩuV3Hub",
                Description = "Script này thì khỏi nói rầu",
                Url = "https://raw.githubusercontent.com/traurobloxdeptrai/traukhoaito/refs/heads/main/traurobloxv3.lua"
            },
            {
                Type = "Loadstring",
                Title = "SpeedHubV5",
                Description = "Script này giao diện sẽ k quen mấy nhma sài cx ổn",
                Url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "ZisHub",
                Description = "Script này farm cx đc",
                Url = "https://github.com/LuaCrack/Zis/raw/refs/heads/main/ZisUp27Vn",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "Script BananaPreFake",
                Description = "tất cả cx ổn mà sea event chx test=))",
                Url = "https://raw.githubusercontent.com/kimprobloxdz/Banana-Free/refs/heads/main/Protected_5609200582002947.lua.txt"
            },
            {
                Type = "Loadstring",
                Title = "Script TeddyHub",
                Description = "tự mà get key ko muốn ib a lấy key=))",
                Url = "https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM",
                PreFunc = function()
                    repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
                end
            },
            {
                Type = "Loadstring",
                Title = "Script MeowHub",
                Description = "áp dụng với mấy game khác dùng để tìm SV ít người",
                Url = "https://raw.githubusercontent.com/anuragaming1/Meow_gaming/refs/heads/main/Servervip.lua.txt"
            },
            {
                Type = "Loadstring",
                Title = "Script Yiner",
                Description = "Script này nghe nói là auto bounty mà hok sài đủ lâu nên k bic",
                Url = "https://raw.githubusercontent.com/anuragaming1/Meow_gaming/refs/heads/main/Servervip.lua.txt"
            },
            {
                Type = "Loadstring",
                Title = "Script blueXHub",
                Description = "Script này là hàng colab giữa admin blue với Redz real nên hơi khác nhma rất ngon nhé",
                Url = "https://raw.githubusercontent.com/anuragaming1/Meow_gaming/refs/heads/main/Servervip.lua.txt"
            },
            {
                Type = "Loadstring",
                Title = "Script MaruHubFreemium",
                Description = " thấy Sài thì kém sang hơn pre nhma sài ngon hơn=)) ",
                Url = "https://raw.githubusercontent.com/natoppo044/GGEZ/refs/heads/main/MaruHub.lua",
                PreFunc = function()
                    getgenv().Team = "Marines"
                end
            },
            {
                Type = "Loadstring",
                Title = "Script MasterHub(DoraemonHub)",
                Description = "Sài tạm tạm ngon hay k tùy người ",
                Url = "https://raw.githubusercontent.com/anuragaming1/Meow_gaming/refs/heads/main/Servervip.lua.txt"
            },
            {
                Type = "Loadstring",
                Title = "Script DatThgV1",
                Description = " Script này k phải là script của tui nhá",
                Url = "https://raw.githubusercontent.com/LuaCrack/DatThg/refs/heads/main/DatThgV1"
            },
            {
                Type = "Loadstring",
                Title = "Script TsuoHub",
                Description = "script này tùy hứng lắm",
                Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"
            },
            {
                Type = "Loadstring",
                Title = "Script QuanTumOnyx",
                Description = " Script này cái cx ngon trừ seaevent ra=))",
                Url = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"
            }
        }
    },
    Main2 = {
        Title = "StealABrainGod🐘",
        Items = {
            {
                Type = "Loadstring",
                Title = "VietNamHub",
                Description = "Script này cx đc tại k chs steal nhiều nên tự trải nghiệm",
                Url = "https://raw.githubusercontent.com/replit8173/VietnamHub/refs/heads/main/VietnamseHub.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "ChilliHub",
                Description = "Script này cx đc tại k chs steal nhiều nên tự trải nghiệm",
                Url = "https://api.luarmor.net/files/v3/loaders/a3e13a4a85ac4c2da17a6baab051ee1b.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "YouiHub",
                Description = "Script này cx đc tại k chs steal nhiều nên tự trải nghiệm",
                Url = "https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/Instant%20Steal%20V2.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            }
        }
    },
    Main3 = {
        Title = "99 Đêm Trong Rừng🌲",
        Items = {
            {
                Type = "Loadstring",
                Title = "Script FoxNameHub",
                Description = " ổn dùng ổn định k quá rồi good",
                Url = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"
            },
            {
                Type = "Loadstring",
                Title = "Script RingTaHub",
                Description = "cx ổn=))",
                Url = "https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua"
            },
            {
                Type = "Loadstring",
                Title = "Script GecHub",
                Description = " tự sài mà cảm nhận đi ai rảnh mà nói hoài ",
                Url = "https://raw.githubusercontent.com/GEC0/gec/refs/heads/main/Gec.Loader"
            },
            {
                Type = "Loadstring",
                Title = "Script VoidWare",
                Description = "Script xịn nha",
                Url = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "Script TeuHub",
                Description = "Script của bạn tếu mới làm nên k xịn lắm ",
                Url = "https://raw.githubusercontent.com/teoscrvn/T-ng-h-p-/refs/heads/main/teoupdate.txt"
            }
        }
    },
    Main4 = {
        Title = "GardenTowerDefense🌻",
        Items = {
            {
                Type = "Loadstring",
                Title = "ShadowHub",
                Description = "Lưu ý cần key, Script ngon nhá",
                Url = "https://raw.githubusercontent.com/RilShadow10/ShadowHub/master/loader.lua",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "InfiniteyieldHub",
                Description = "cái này k cần key mà để chỉ dùng noclip hoặc fly thui nhớ đọc kỹ hướng dẫn sử dụng!",
                Url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            },
            {
                Type = "Loadstring",
                Title = "NeoxHub",
                Description = "nghe nói cái này dùng để antiafk và antiban ai mà bt=))!",
                Url = "https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn",
                PreFunc = function()
                    getgenv().Settings = { JoinTeam = true, Team = "Marines" }
                end
            }
        }
    },
    Main5 = {
        Title = "plan vs brainrot🫨",
        Items = {
            {
                Type = "Loadstring",
                Title = "Script SpeedHub",
                Description = " ổn dùng ổn định k quá rồi good👍  ",
                Url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"
            },
            {
                Type = "Loadstring",
                Title = "Script KhanhLyHub",
                Description = " ổn dùng ổn định k quá rồi good👍  ",
                Url = "https://raw.githubusercontent.com/khoavipok/Khanhlytbao/refs/heads/main/Plants%20Vs%20Brainrots"
            }
        }
    }
}

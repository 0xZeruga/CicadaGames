var img1 = document.querySelectorAll(".image1");
var characterNames = [];
var characterRole = [];
var characterElement = [];
var characterRarity = [];
var characterHealth = [];
var characterDamage = [];
var characterAccuracy = [];
var characterEvasion = [];

function readSpreadSheet(){
    var publicSpreadsheetUrl = 'https://docs.google.com/spreadsheets/d/1fsOLm2udyqplHmSwlq-16pAy8XOPFj4cyYzmuaocxNE/edit?usp=sharing';

    function init() {
        Tabletop.init( { key: publicSpreadsheetUrl,
                     callback: addCharInfo,
                     simpleSheet: true } )
    }

    function addCharInfo(data, tabletop) {

        data.forEach(function(obj) {
            var stringifyObj = JSON.stringify(obj);
            var jObj = JSON.parse(stringifyObj);

            characterNames.push(jObj.Name);
            characterRole.push(jObj.Role);
            characterElement.push(jObj.Element);
            characterRarity.push(jObj.Rarity);
            characterHealth.push(jObj.Health);
            characterDamage.push(jObj.Damage);
            characterAccuracy.push(jObj.Accuracy);
            characterEvasion.push(jObj.Evasion);
        });

    }

    window.addEventListener('DOMContentLoaded', init)
}

function randomizeBackground(){
    var ranNum = Math.floor((Math.random() * 4) + 1);
    $('body').css("background-image", "url(backgroundImages/Battleground" + ranNum + ".png)");

    if(ranNum === 1){
        $('table').css("background-color", "#045e4f");
        $('table').css("border", "10px ridge #02382f");
        $('tr').css("background-color", "#045e4f");
        $('tr').css("border", "5px ridge #02382f");
    }
    if(ranNum === 2){        
        $('p').css("color", "white");
    }
    if(ranNum === 3){
        $('table').css("background-color", "#808000");
        $('table').css("border", "10px ridge #897129");
        $('tr').css("background-color", "#808000");
        $('tr').css("border", "5px ridge #897129");
    }
    if(ranNum === 4){
        $('table').css("background-color", "#1d671a");
        $('table').css("border", "10px ridge #124211");
        $('tr').css("background-color", "#1d671a");
        $('tr').css("border", "5px ridge #124211");
    }
}

function populateSelectionTableImages(){

    var count = 0;

    $('.imageDisplay img').each(function() {
        var imge = $( this ).attr('src');
        count = count + 1;

        $('tbody').append(
            "<tr><td class='imgRow'><img id='scrollImg' src='" + imge + "' alt=''></td><td class='nameRow'><p class='charName" + count + "'>Character Name</p><p id='level'>Level: </p></td></tr>"
        );
    });

    setTimeout(function() {
        for(var i = 0; i < characterNames.length; i++){
            
            $(".charName" + (i + 1)).text(characterNames[i]);
        }
    }, 1000);

}

function removeSideImageDisplay(){
    for(var i = 0; i < img1.length; i++){
        img1[i].style.display = "none";
    }
}

function mouseOverImage(){
    var scrollImages = document.querySelectorAll("#scrollImg");
    var trows = document.querySelectorAll("tr");
    var count = 0;

    scrollImages.forEach(function(imag, i){
        scrollImages[i].addEventListener("mouseover", function(){
            img1[i].style.display = "block";
        });
        scrollImages[i].addEventListener("mouseleave", function(){
            img1[i].style.display = "none";
        });
    });


    trows.forEach(function(imag, i) {
        trows[i].addEventListener("mouseover", function(){
            count = count + 1;
            img1[i - 1].style.display = "block";

            if((count <= 1)){
                $('.titleName').append("<h1>" + characterNames[i-1] + "</h1>");
                $('.dataGrid').append(
                    "<div id='grid'><div class='charItem'>Level</div><div class='charItem'>Role</div><div class='charItem'>Element</div><div class='charItem'>Rarity</div><div class='charItem'>Health</div><div class='charItem'>Damage</div><div class='charItem'>Accuracy</div><div class='charItem'>Evasion</div><div class='charItem'></div><div class='charItem'>" + characterRole[i-1] + "</div><div class='charItem'>" + characterElement[i-1] + "</div><div class='charItem'>" + characterRarity[i-1] + "</div><div class='charItem'>" + characterHealth[i-1] + "</div><div class='charItem'>" + characterDamage[i-1] + "</div><div class='charItem'>" + characterAccuracy[i-1] + "</div><div class='charItem'>" + characterEvasion[i-1] + "</div></div>"
                );
                
                //check character length in name
                if(characterNames[i-1].length > 21){
                    $('h1').css("font-size", "4rem");
                }
            }
        })
        trows[i].addEventListener("mouseleave", function(){
            count = 0;
            img1[i-1].style.display = "none";
            $('.titleName').children("h1").remove();
            $('.dataGrid').children("div").remove();
        })
        trows[i].addEventListener("click", function(){
            //redirect to HTML Page w/ character more info
            window.location.replace("");
        })
    })
}

function scrollDisplay(){
    removeSideImageDisplay();
    mouseOverImage();
}

readSpreadSheet();
populateSelectionTableImages();
randomizeBackground();
scrollDisplay();
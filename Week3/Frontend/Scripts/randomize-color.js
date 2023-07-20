function getRandomColor() {
    var randomColor = Math.floor(Math.random()*16777215).toString(16);
    return "#" + randomColor;
}

function oppositeColor(color) {
    var r = parseInt(color.substr(1, 2), 16);
    var g = parseInt(color.substr(3, 2), 16);
    var b = parseInt(color.substr(5, 2), 16);
    var newR = 255 - r;
    var newG = 255 - g;
    var newB = 255 - b;
    var res =  "#" + padZero(newR.toString(16)) + padZero(newG.toString(16)) + padZero(newB.toString(16));
    return res;
}

function padZero(str) {
    var res = str;
    while (res.length < 2) {
        res = "0" + res;
    }
    return res;
}

list = document.getElementsByClassName("random");
for (var i = 0; i < list.length; i++) {
    var color = getRandomColor();
    list[i].style.color = color;
    list[i].style.backgroundColor = oppositeColor(color);
}
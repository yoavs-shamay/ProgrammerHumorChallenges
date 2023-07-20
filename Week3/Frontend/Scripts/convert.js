function download(fileName, blob)
{
    //TODO save blob
    var url = window.URL.createObjectURL(blob);
    var a = document.createElement("a");
    a.href = url;
    a.download = fileName;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
}

function convert()
{
    var matrixJSON = document.getElementById("matrix-input").value;
    var matrix = JSON.parse(matrixJSON);
    var x = matrix.length;
    var y = matrix[0].length;
    var z = matrix[0][0].length;
    var name = document.getElementById("name-input").value;
    var matrixString = "";
    var fileName = document.getElementById("file-name-input").value;
    for (var i = 0; i < x; i++)
    {
        for (var j = 0; j < y; j++)
        {
            for (var k = 0; k < z; k++)
            {
                matrixString += matrix[i][j][k] + " ";
            }
        }
    }
    matrixString = matrixString.trim();
    var date = Math.floor(Date.now() / 1000);
    var url = "https://20.115.123.241:1795/generate?creatorName=" + name + "&creationDate=" + date.toString() + "&x=" + x.toString() + "&y=" + y.toString() + "&z=" + z.toString();
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", url, true);
    xhttp.setRequestHeader("Content-Type", "text/plain");
    xhttp.responseType = "blob";
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = this.response;
            download(fileName, response);
        }
    };
    xhttp.send(matrixString);
}
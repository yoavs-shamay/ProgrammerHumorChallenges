function parse()
{
    var file = document.getElementById("file-input").files[0];
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "http://localhost:1795/parse", true);
    xhttp.setRequestHeader("Content-Type", "text/plain");
    xhttp.send(file);
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = this.responseText;
            var textSplit = response.split(" ");
            var date = textSplit[0];
            var name = textSplit[1];
            var x = parseInt(textSplit[2]);
            var y = parseInt(textSplit[3]);
            var z = parseInt(textSplit[4]);
            var matrixVals = textSplit.slice(5);
            var matrix = [];
            for (var i = 0; i < x; i++)
            {
                cur = []
                for (var j = 0; j < y; j++)
                {
                    curr = []
                    for (var k = 0; k < z; k++)
                    {
                        curr.push(matrixVals[i * y * z + j * z + k]);
                    }
                    cur.push(curr);
                }
                matrix.push(cur);
            }
            var matrixJSON = JSON.stringify(matrix);
            document.getElementById("matrix-output").value = matrixJSON;
            document.getElementById("name-output").value = name;
            document.getElementById("date-output").value = date;
        }
    };
}
url = window.location.href;
url = url.split("/");
if (url.length > 0)
    url = url.slice(0, url.length - 1); 
url = url.join("/");
url += "/Week3/Frontend/convert.html";
window.location.href = url;
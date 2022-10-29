class JSONTree extends HTMLElement {
    constructor() {
        super();
        let url = this.getAttribute("src") || "";
        if (url == "") {
            return;
        }
        let container = document.createElement("ul");
        container.style.fontFamily = "Consolas"
        $.getJSON(url, function (data) {
            spawn(data, container);
        });

        function toLine(str) {
            var temp = str.replace(/([A-Z]|[0-9])/g, function (match) {
                return "_" + match.toLowerCase();
            });
            temp = temp.replace(/[0-9]_[a-z]/g, function (match){
                let tmp = match.split("_")
                return tmp[0] + tmp[1]
            })
            if (temp.slice(0, 1) === "_") {
                temp = temp.slice(1);
            }
            return temp;
        }
        function spawn(current, container) {
            for (var index in current) {
                if (index == "@@self") {
                    continue;
                }
                let type = typeof current[index];
                let li;
                let icon;
                let span;
                switch (type) {
                    case "string":
                        icon = document.createElement("img");
                        icon.style.width = "16px";
                        icon.style.height = "16px";
                        icon.style.verticalAlign = "text-top";
                        icon.style.marginRight = "4px";
                        icon.src =
                            "/icons/icon_" + toLine(current[index]) + ".svg";
                        li = document.createElement("li");
                        li.style.listStyle = "none";
                        span = document.createElement("span");
                        span.innerHTML = index;
                        span.title = current[index]
                        li.appendChild(icon);
                        li.appendChild(span);
                        container.appendChild(li);
                        break;
                    case "object":
                        let ul = document.createElement("ul");
                        icon = document.createElement("img");
                        icon.style.width = "16px";
                        icon.style.height = "16px";
                        icon.style.verticalAlign = "text-top";
                        icon.style.marginRight = "4px";
                        icon.src =
                            "/icons/icon_" +
                            toLine(current[index]["@@self"]) +
                            ".svg";
                        span = document.createElement("span");
                        span.innerHTML = index;
                        span.title = current[index]["@@self"]
                        li = document.createElement("li");
                        li.style.listStyle = "none";
                        li.appendChild(icon);
                        li.appendChild(span);
                        li.appendChild(ul);
                        container.appendChild(li);
                        spawn(current[index], ul);
                        break;
                }
            }
        }
        this.appendChild(container);
    }
}

window.onload = () => customElements.define("json-tree", JSONTree);

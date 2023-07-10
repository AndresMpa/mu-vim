/*
  Open this link

  https://cssreference.io/

  Then copy paste the script and copy paste the output on a file called rawData.txt

  Then execute parser.sh
*/

const source = document.querySelectorAll("article.finder-item");

const attributes = [];

source.forEach((attributePair) => {
  const cssAttribute = attributePair.querySelector("a").textContent;
  const attributeDescription = attributePair.querySelector("div").textContent;

  attributes.push(`${cssAttribute}:${attributeDescription}\n`);
});

const snippetAsHTML = [];

attributes.forEach((attributeAsString) => {
  const rawSnippet = document.createElement("div");
  rawSnippet.textContent = attributeAsString;
  snippetAsHTML.push(rawSnippet);
});

const clickableContainer = document.createElement("div");
clickableContainer.append(...snippetAsHTML);

const target = document.querySelector("h1");
target.parentNode.insertBefore(clickableContainer, target);


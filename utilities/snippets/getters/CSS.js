/*
  Open this link

  https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes

  Then copy paste the script and copy paste the output on a file called rawData.txt

  Then execute parser.sh
*/

const source = document.querySelectorAll("table.standard-table tbody td:first-child code");
const description = document.querySelectorAll("table.standard-table tbody td:last-child");

const rawHTMLAttributesDescription = [...description].map((item) =>
  item.textContent.replaceAll("\n", "").replaceAll("\t", "")
);
const rawHTMLAttributesDataTags = [...source].map((item) => item.textContent);

const rawHTMLAttributesData = () => {
  let rawSnippetString = "";
  const rawSnippets = [];
  let string;

  rawHTMLAttributesDataTags.forEach((tag, index) => {
    string = `${tag}:${rawHTMLAttributesDescription[index]}\n`;

    const rawSnippet = document.createElement("div");
    rawSnippet.textContent = string;

    rawSnippets.push(rawSnippet);
    rawSnippetString += string;
  });

  console.log(rawSnippetString);

  const clickableContainer = document.createElement("div");
  clickableContainer.append(...rawSnippets);

  const target = document.querySelector("div.section-content");
  target.parentNode.insertBefore(clickableContainer, target);
};

rawHTMLAttributesData();

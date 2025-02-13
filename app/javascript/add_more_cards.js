document.addEventListener("turbo:load", initAddMoreCards);
document.addEventListener("DOMContentLoaded", initAddMoreCards);

function initAddMoreCards() {
  const addButton = document.getElementById("add-card-btn");
  const cardFieldsContainer = document.querySelector(".card-fields-container");

  if (addButton && cardFieldsContainer) {
    let cardIndex = document.querySelectorAll(".card-field").length;

    addButton.removeEventListener("click", addCards);
    addButton.addEventListener("click", addCards);

    function addCards() {
      for (let i = 0; i < 5; i++) {
        cardIndex++;
        const cardField = document.createElement("div");
        cardField.className = "mb-7 card-field";
        cardField.innerHTML = `
          <div class="flex items-baseline border-b border-gray-300 w-[85%] min-w-96 mr-20 mb-2">
            <label class="font-bold">Question</label>
            <textarea name="card_collection[cards_attributes][${cardIndex}][question]" placeholder="Write a question" class="px-3 py-2 w-full border-none focus:outline-none focus:ring-0 h-[40px]"></textarea>
          </div>
          <div class="flex items-baseline border-b border-gray-300 w-[85%] min-w-96">
            <label class="font-bold">Answer</label>
            <textarea name="card_collection[cards_attributes][${cardIndex}][answer]" placeholder="Write an answer" class="px-3 py-2 w-full border-none focus:outline-none focus:ring-0 h-[40px]"></textarea>
          </div>
        `;
        cardFieldsContainer.appendChild(cardField);
      }
    }
  }
}



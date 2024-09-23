document.addEventListener("turbo:load", function() {
  let cardIndex = document.querySelectorAll(".card-field").length;

  document.getElementById("add-card-btn").addEventListener("click", function() {
    const form = document.querySelector("form");
    const cardFieldsContainer = form.querySelector(".card-fields-container");
    
    for (let i = 0; i < 5; i++) {
      cardIndex++;
      const cardField = document.createElement("div");
      cardField.classList.add("mb-7", "card-field");
      cardField.innerHTML = `
        <div class="flex items-center border-b border-gray-300 w-[85%] min-w-96 mr-20 mb-2">
          <label for="card_collection_cards_attributes_${cardIndex}_question" class="font-bold">Question</label>
          <textarea name="card_collection[cards_attributes][${cardIndex}][question]" id="card_collection_cards_attributes_${cardIndex}_question" placeholder="Write a question" class="px-3 py-2 w-full border-none focus:outline-none focus:ring-0 h-[40px]"></textarea>
        </div>
        <div class="flex items-center border-b border-gray-300 w-[85%] min-w-96">
          <label for="card_collection_cards_attributes_${cardIndex}_answer" class="font-bold">Answer</label>
          <textarea name="card_collection[cards_attributes][${cardIndex}][answer]" id="card_collection_cards_attributes_${cardIndex}_answer" placeholder="Write an answer" class="px-3 py-2 w-full border-none focus:outline-none focus:ring-0 h-[40px]"></textarea>
        </div>
      `;
      cardFieldsContainer.appendChild(cardField);
    }
  });
});


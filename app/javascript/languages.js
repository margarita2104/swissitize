document.addEventListener("turbo:load", initLanguages);
document.addEventListener("DOMContentLoaded", initLanguages);

function initLanguages() {
  const languageSelect = document.querySelector('[data-languages-target="select"]');
  const selectedListDiv = document.querySelector('[data-languages-target="selectedList"]');
  const hiddenInput = document.querySelector('[data-languages-target="input"]');
  
  if (!languageSelect || !selectedListDiv || !hiddenInput) return;

  // Initialize languages Set with existing languages
  let languages = new Set();
  try {
    // Get existing languages from the hidden input's parent (where we'll store our hidden fields)
    const existingInputs = hiddenInput.parentNode.querySelectorAll('input[name="user[languages][]"]');
    existingInputs.forEach(input => languages.add(input.value));
    
    // If no existing inputs but we have a value in hiddenInput, use that
    if (existingInputs.length === 0 && hiddenInput.value) {
      const currentLanguages = JSON.parse(hiddenInput.value || '[]');
      currentLanguages.forEach(lang => languages.add(lang));
    }
  } catch (e) {
    console.error('Error parsing languages:', e);
  }

  function updateDisplay() {
    const languagesArray = Array.from(languages);
    console.log('Updating languages:', languagesArray);
    
    // Create separate hidden inputs for each language
    const existingInputs = document.querySelectorAll('input[name="user[languages][]"]');
    existingInputs.forEach(input => input.remove());

    languagesArray.forEach(language => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'user[languages][]';
      input.value = language;
      hiddenInput.parentNode.appendChild(input);
    });
    
    // Update display
    selectedListDiv.innerHTML = languagesArray.map(language => `
      <div class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full flex items-center gap-2">
        ${language}
        <button type="button" 
                class="text-blue-500 hover:text-blue-700 remove-language" 
                data-language="${language}">
          ×
        </button>
      </div>
    `).join('');

    // Add event listeners to new remove buttons
    selectedListDiv.querySelectorAll('.remove-language').forEach(button => {
      button.addEventListener('click', removeLanguage);
    });
  }

  function handleLanguageSelect(event) {
    const language = event.target.value;
    if (language && !languages.has(language)) {
      languages.add(language);
      updateDisplay();
      event.target.value = '';
    }
  }

  function removeLanguage(event) {
    const language = event.currentTarget.dataset.language;
    languages.delete(language);
    updateDisplay();
  }

  languageSelect.addEventListener('change', handleLanguageSelect);
  updateDisplay(); // Initial display of existing languages
}
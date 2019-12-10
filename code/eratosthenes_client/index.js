const URL = "http://localhost:3000/identify_prime_numbers";

document.getElementById('addPostForm').addEventListener('submit', addPost);

function addPost(event) {
    event.preventDefault();
    
    let values = document.getElementById('values').value;
    let numbers = document.getElementById('numbers');

    numbers.innerHTML = "<p>Carregando...";
    
    const myPost = {
        values: values
    };
    
    fetch(URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(myPost)
    })
        .then((res) => res.json())
        .then((data) => numbers.innerHTML = getListOfNumbers(data));
}

const getListOfNumbers = (data) => {
    const numbers = data.response.numbers
      .map((number) => `<tr><td>${number.value}</td><td>${isPrime(number.prime)}</td></tr>`)
      .join("\n");
  
    return `<table><tr><th>Entrada</th><th>Primo</th></tr>${numbers}</table>`;
};

function isPrime(value) {
    return (value != null) ? value : '?';
}
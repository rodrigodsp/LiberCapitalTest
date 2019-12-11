const URL = "http://localhost:3000/identify_prime_numbers";
const pattern = new RegExp("^[0-9]+(,[0-9]+)*$");

var intervalId = 0;

document.getElementById('addPostForm').addEventListener('submit', addPost);

function addPost(event) {
    event.preventDefault();

    if(intervalId > 0) {
        clearInterval(intervalId);
    }

    let values = document.getElementById('values').value;
    let numbers = document.getElementById('numbers');

    if(pattern.test(values)) {    
        numbers.innerHTML = "<p>Carregando...</p>";    
        intervalId = setInterval(postRequest, 3000, values, numbers);
    } else {
        alert("Valores inválidos, tente outra vez!\n\nDeve ser fornecida uma lista de valores inteiros\nseparados por vírgula.");
    }
}

function postRequest(values, numbers) {
       
    if(numbers.innerHTML.indexOf("?") > 0 || numbers.innerHTML.indexOf("Carregando") > 0) {
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

    } else { 
        clearInterval(intervalId);
    }
    
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
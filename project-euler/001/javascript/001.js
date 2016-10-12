const multiplier1 = 3;
const multiplier2 = 5;
const maxNum = 1000;

let i = 1;
let sum = 0;

while (i < maxNum) {
  if (i % multiplier1 == 0 || i % multiplier2 == 0) {
    sum += i;
  }
  i++;
}
console.log(sum);
return;

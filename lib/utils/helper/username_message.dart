String getUsernameMessage(int tries) {
  if (tries <= 2) {
    return "Perfect! You got your username instantly ✨";
  } 
  else if (tries <= 10) {
    return "Nice! You explored a few ideas before choosing 👍";
  } 
  else {
    return "Wow 😲 you really went through a whole identity crisis before choosing this username 🔥";
  }
}
// // src/apollo/apollo-client.js
// import {
//   ApolloClient,
//   InMemoryCache,
//   from,
// } from "@apollo/client/core";
// import { setContext } from "@apollo/client/link/context";
// // import { createUploadLink } from "apollo-upload-client";

// const uploadLink = createUploadLink({
//   uri: "http://localhost:3000/graphql",
// });

// const authLink = setContext((_, { headers }) => {
//   const token = localStorage.getItem("authToken");
//   return {
//     headers: {
//       ...headers,
//       authorization: token ? `Bearer ${token}` : "",
//     },
//   };
// });

// const apolloClient = new ApolloClient({
//   link: from([authLink, uploadLink]),
//   cache: new InMemoryCache(),
// });

// export default apolloClient;





import {
  ApolloClient,
  InMemoryCache,
  HttpLink,
  from,
} from '@apollo/client/core';
import { setContext } from '@apollo/client/link/context';

// 1. Create the standard HTTP link
const httpLink = new HttpLink({
  uri: 'http://localhost:3000/graphql',
});

// 2. Create the authentication link to send the JWT token
const authLink = setContext((_, { headers }) => {
  const token = localStorage.getItem('authToken');
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : '',
    },
  };
});

// 3. Combine links (auth comes before http)
const link = from([authLink, httpLink]);

// 4. Apollo Client instance
const apolloClient = new ApolloClient({
  link: link,
  cache: new InMemoryCache(),
});

export default apolloClient;

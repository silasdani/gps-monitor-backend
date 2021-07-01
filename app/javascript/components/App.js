import React from 'react'
import { Route, Switch } from 'react-router-dom';
import Users from './Users/Users';
import User from './User/User'; 
import Home from './Home'
const App = () => {
    return (
    <Switch>
        <Route exact path = "/ruby" component = { Users }/>
        <Route exact path = "/ruby/users/:id" component = { User }/>
    </Switch>
    )
}

export default App;
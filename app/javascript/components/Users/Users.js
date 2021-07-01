import React, { useState, useEffect } from 'react'
import axios from 'axios'
const Users = () => {
    const [users, setUsers] = useState([])
    useEffect(() => {
        //geting all users from api
        axios.get('/users')
        .then(resp => console.log(resp))
        .catch( resp => console.log(resp))

    }, [users.length])
    return (
        <div>This is the Users index</div>
    )
}

export default Users
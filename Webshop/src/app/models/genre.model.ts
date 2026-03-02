export class Genre {
    constructor(
        public id: number | null,
        public name: string,
        public isDeleted: boolean = false
    ) { }
}
